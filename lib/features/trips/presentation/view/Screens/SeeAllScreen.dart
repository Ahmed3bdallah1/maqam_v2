import 'package:flutter/material.dart';


import '../../../models/trip_model.dart';

import '../widgets/trip_widget.dart';
import 'DetailsScreen.dart';


class AllTripsScreen extends StatelessWidget {
  final List<Trip> trips;
  const AllTripsScreen({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('All Trips'),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 9,
            mainAxisSpacing: 10,
          ),
          itemCount: trips.length, // Adjust the number of items based on your data
          itemBuilder: (context, index) {

            return Center(
              child: GestureDetector(
                onTap: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>DetailsScreen(trip: trips[index]),
                    ),
                  );
                },

                child: TripWidget2(
                  image: trips[index].images[0],
                  location: trips[index].location,
                  title: trips[index].name, // Replace with actual location data
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}