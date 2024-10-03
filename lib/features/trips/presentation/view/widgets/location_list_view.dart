import 'package:flutter/material.dart';
import 'package:maqam_v2/features/trips/models/location.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../di_container.dart';
import '../screens/all_trips_screeen.dart';
import 'location_widget.dart';

class LocationListView extends StatelessWidget {
  final Future<List<LocationModel>> future;
  final List<Trip> trips;

  const LocationListView(
      {super.key, required this.future, required this.trips});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocationModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  var list = sl<TripsCubit>()
                      .tripsRepo
                      .filterTrips(trips, data![index].location);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllTripsScreen(
                        trips: list,
                        categoryName: data[index].location,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: LocationWidget(
                    image: 'assets/images/img1.png',
                    location: snapshot.data![index].location,
                  ),
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.green.shade300,
                  child: Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Image.asset(
              "assets/images/error.png",
              height: 30,
            ),
          );
        }
      },
    );
  }
}

class LocationGridView extends StatelessWidget {
  final Future<List<LocationModel>> future;
  final List<Trip> trips;

  const LocationGridView(
      {super.key, required this.future, required this.trips});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocationModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data;
          return GridView.builder(
            itemCount: data?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    var list = sl<TripsCubit>()
                        .tripsRepo
                        .filterTrips(trips, data![index].location);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllTripsScreen(
                          trips: list,
                          categoryName: data[index].location,
                        ),
                      ),
                    );
                  },
                  child: LocationWidget(
                    image: 'assets/images/img1.png',
                    color: Colors.grey.withOpacity(.3),
                    location: snapshot.data![index].location,
                  ),
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.green.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            "assets/images/img1.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Location",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else{
          return SizedBox();
        }
      },
    );
  }
}
