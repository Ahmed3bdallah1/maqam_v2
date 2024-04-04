import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/core/widgets/snakbar.dart';
import 'package:maqam_v2/features/cart/models/reservation_model.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';
import '../../../../core/constants.dart';

class ReservationScreen extends StatelessWidget {
  final List<Trip> cartList;

  const ReservationScreen({super.key, required this.cartList});

  @override
  Widget build(BuildContext context) {
    final List<String> names = [];
    List<String> namesList() {
      for (var i in cartList) {
        names.add(i.name);
      }
      print(names);
      return names;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotel Reservation',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ReservationForm(
          cartList: namesList(),
          trips: cartList,
        ),
      ),
    );
  }
}

class ReservationForm extends StatefulWidget {
  final List<String> cartList;
  final List<Trip> trips;

  const ReservationForm({super.key, required this.cartList, required this.trips});

  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  File? file;
  String? downloadUrl;
  String name = '';
  String email = '';
  String phoneNumber = '';
  int numberOfGuests = 1;
  int numberOfBags = 0;
  bool peakFromAirport = false;
  DateTime? arrivalDate;
  String comments = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.green),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.green),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.green),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                phoneNumber = value;
              });
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text(
              'Number of Guests',
              style: TextStyle(color: Colors.green),
            ),
            trailing: DropdownButton<int>(
              value: numberOfGuests,
              onChanged: (newValue) {
                setState(() {
                  numberOfGuests = newValue!;
                });
              },
              items: List.generate(
                10,
                (index) => DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text('${index + 1}'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text(
              'Peak from Airport',
              style: TextStyle(color: Colors.green),
            ),
            value: peakFromAirport,
            onChanged: (newValue) {
              setState(() {
                peakFromAirport = newValue;
              });
            },
          ),
          if (peakFromAirport) ...[
            const SizedBox(height: 10),
            ListTile(
              title: const Text(
                'Number of Bags',
                style: TextStyle(color: Colors.green),
              ),
              trailing: DropdownButton<int>(
                value: numberOfBags,
                onChanged: (newValue) {
                  setState(() {
                    numberOfBags = newValue!;
                  });
                },
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem<int>(
                    value: index,
                    child: Text('$index'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Arrival Date:',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (selectedDate != null) {
                  setState(() {
                    arrivalDate = selectedDate;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                arrivalDate != null
                    ? '${arrivalDate!.day}/${arrivalDate!.month}/${arrivalDate!.year}'
                    : 'Select Date',
                style: const TextStyle(color: Colors.green),
              ),
            ),
            const SizedBox(height: 10),
            file != null
                ? SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Image.file(file!))
                : ElevatedButton(
                    onPressed: () async {
                      file = await pickImage();
                      final path = await FirebaseStorage.instance
                          .ref("tickets")
                          .child(FirebaseAuth.instance.currentUser!.uid);

                      if (file != null) {
                        final taskSnapshot = await path.putFile(file!);
                        downloadUrl = await taskSnapshot.ref.getDownloadURL();
                      }
                      setState(() {});
                      print('Upload Ticket');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Upload Ticket',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
          ],
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Comments',
              prefixIcon: Icon(Icons.comment, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            maxLines: null,
            style: const TextStyle(color: Colors.green),
            onChanged: (value) {
              setState(() {
                comments = value;
              });
            },
          ),
          const SizedBox(height: 20),
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              final cubit = CartCubit.get(context);
              return ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Process reservation

                    final reservation = ReservationModel(
                      name: name,
                      phoneNumber: phoneNumber,
                      peakOfAirport: peakFromAirport,
                      arrivalTime: arrivalDate,
                      numberOfBags: numberOfBags,
                      fileUrl: downloadUrl,
                      email: email,
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      numberOfGuests: numberOfGuests,
                      cartItems: widget.cartList,
                      comments: comments,
                    );

                    final res = await cubit.addReservation(reservation);

                    if (res) {
                      for(var i in widget.trips){
                        cubit.remove(i);
                        cubit.cartItems.clear();
                      }
                      showSnakbar(
                          context, "reservation added successfully", Green);
                      Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
