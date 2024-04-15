import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';
import 'package:maqam_v2/features/trips/presentation/view/screens/see_all_location.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/head_home_title.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/location_list_view.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/trips.dart';
import '../../../../search/presentation/view/search_screen.dart';
import 'all_trips_screeen.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripsCubit, TripsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final TripsCubit cubit = TripsCubit.get(context);
        return StreamBuilder(
          stream: cubit.getTrips(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tripsData = snapshot.data!;
              final trips = tripsData.toList();
              return ListView(children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const SearchScreen(searchBar: true)));
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Search',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HeadHomeTitle(title: "Locations"),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SeeAllLocationScreen(trips: trips),
                                  ),
                                );
                              },
                              child: GestureDetector(
                                child: const Text('See All',
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 40,
                          child: LocationListView(
                              future: cubit.getLocation(), trips: trips)),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HeadHomeTitle(title: 'Popular Trips'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllTripsScreen(
                                      trips: trips,
                                      categoryName: 'Popular',
                                    ),
                                  ),
                                );
                              },
                              child: const Text('See All',
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Trips(trips: trips),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HeadHomeTitle(title: 'Recommended Trips'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllTripsScreen(
                                      trips: trips,
                                      categoryName: "Recommended",
                                    ),
                                  ),
                                );
                              },
                              child: const Text('See All',
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Trips(trips: trips),
                    ]))
              ]);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          },
        );
      },
    );
  }
}
/*

* */
