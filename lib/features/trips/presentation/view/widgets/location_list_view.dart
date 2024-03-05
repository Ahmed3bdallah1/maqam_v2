import 'package:flutter/material.dart';
import 'package:maqam_v2/features/trips/models/location.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';

import '../screens/all_trips_screeen.dart';
import 'location_widget.dart';

class LocationListView extends StatelessWidget {
  final Future<List<LocationModel>> future;
  final List<Trip> trips;
  const LocationListView({super.key, required this.future, required this.trips});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocationModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.done) {
          final data = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  var list = TripsCubit.get(context).tripsRepo.filterTrips(
                      trips, data![index].location);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllTripsScreen(trips: list,categoryName: data[index].location,),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 0),
                  child: LocationWidget(
                    image: 'assets/images/img1.png',
                    location:
                    snapshot.data![index].location,
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
