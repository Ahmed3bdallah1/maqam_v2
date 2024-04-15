import 'package:flutter/material.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';
import 'package:maqam_v2/features/trips/presentation/view/screens/details_screen.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/trip_widget.dart';

class Trips extends StatelessWidget {
  final List<Trip> trips;

  const Trips({
    super.key,
    required this.trips,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210, // Set a specific height here
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(trip: trips[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: TripWidget1(
                  title: trips[index].name,
                  image: trips[index].images[0],
                  location: trips[index].location),
            ),
          );
        },
      ),
    );
  }
}

class SearchTrips extends StatelessWidget {
  final Trip tripe;

  const SearchTrips({
    super.key,
    required this.tripe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(trip: tripe),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TripWidget1(
            title: tripe.name,
            image: tripe.images[0],
            location: tripe.location),
      ),
    );
  }
}
