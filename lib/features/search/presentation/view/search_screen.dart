import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_cubit.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_state.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/trips.dart';

class SearchScreen extends StatefulWidget {
  final bool? searchBar;

  const SearchScreen({super.key, this.searchBar = false});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController controller;
  String searchQuery = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.searchBar == false
          ? const CustomAppBar(title: "Search", isRoot: true)
          : AppBar(),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final SearchCubit cubit = SearchCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              onChanged: (x) {
                                setState(() {
                                  cubit.streamTripsByName(name: x);
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: "search",
                                prefixIcon: const Icon(CupertinoIcons.search),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.clear();
                                    },
                                    child: const Icon(Icons.close)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: StreamBuilder(
                            stream:
                                cubit.streamTripsByName(name: controller.text),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                final trips = snapshot.data;
                                final tripsData = trips!.toList();
                                print(tripsData.length);

                                if (tripsData.isEmpty) {
                                  return const Center(
                                    child: Text(
                                        "there is nothing here to meet your words"),
                                  );
                                }

                                return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: .85,
                                            crossAxisCount: 2),
                                    itemCount: tripsData.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: SearchTrips(
                                          tripe: tripsData[index],
                                        ),
                                      );
                                    });
                              } else {
                                return const Text("error in getting data");
                              }
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
