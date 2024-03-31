
import 'package:flutter/material.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Reservation'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ReservationForm(),
      ),
    );
  }
}

class ReservationForm extends StatefulWidget {
  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();

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
            decoration: InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.green),
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
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.green),
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
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.green),
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
          SizedBox(height: 10),
          ListTile(
            title: Text(
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

          SizedBox(height: 10),
          SwitchListTile(
            title: Text(
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
            SizedBox(height: 10),

            ListTile(
              title: Text(
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
            SizedBox(height: 10),
            Text(
              'Arrival Date:',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (selectedDate != null) {
                  setState(() {
                    arrivalDate = selectedDate;
                  });
                }
              },
              child: Text(
                arrivalDate != null
                    ? '${arrivalDate!.day}/${arrivalDate!.month}/${arrivalDate!.year}'
                    : 'Select Date',
                style: TextStyle(color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement uploading ticket functionality
                print('Upload Ticket');
              },
              child: Text(
                'Upload Ticket',
                style: TextStyle(color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          ],
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Comments',
              prefixIcon: Icon(Icons.comment, color: Colors.green),
              border: OutlineInputBorder(),
            ),
            maxLines: null,
            style: TextStyle(color: Colors.green),
            onChanged: (value) {
              setState(() {
                comments = value;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process reservation
                print('Name: $name');
                print('Email: $email');
                print('Phone Number: $phoneNumber');
                print('Number of Guests: $numberOfGuests');
                print('Number of Bags: $numberOfBags');
                print('Peak from Airport: $peakFromAirport');
                if (arrivalDate != null) {
                  print('Arrival Date: $arrivalDate');
                }
                print('Comments: $comments');
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
