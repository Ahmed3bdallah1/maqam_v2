import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/image_view%20widget.dart';
import 'image_details_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Trip trip;

  const DetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   trip.location,
              //   style: const TextStyle(
              //     fontSize: 30,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageViwer(
                          image: trip.images,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, bottom: 10, right: 20),
                child: BlocConsumer<TripsCubit, TripsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    final cubit = TripsCubit.get(context);
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      child: StreamBuilder(
                          stream: cubit.getMaqam(tripName: trip.name),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            }
                            if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.isEmpty) {
                              return const SizedBox();
                            }

                            if (snapshot.hasData && snapshot.data != null) {
                              return ListView.separated(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final list = snapshot.data!.toList();
                                  final item = list[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ImageDetailsScreen(maqam: item),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      child: ClipOval(
                                        child: FancyShimmerImage(
                                          shimmerHighlightColor:
                                              AppColors.Green.withOpacity(.6),
                                          shimmerBaseColor:
                                              AppColors.Green.withOpacity(.2),
                                          imageUrl: item.images[0],
                                          errorWidget: Image.asset(
                                              'assets/images/error.png'),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 10);
                                },
                              );
                            }
                            return Container(
                              height: MediaQuery.of(context).size.height * .1,
                            );
                          }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  trip.name,
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.Green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            trip.location,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.Green),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: Text(
                          "Price : ${trip.price.toString()} US",
                          style: TextStyle(color: AppColors.Green, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  child: Flexible(
                    child: Text(
                      trip.description,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.Green),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.note,
                          style: TextStyle(color: AppColors.Green, fontSize: 20),
                        ),
                        Text(
                          AppStrings.notes,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CartCubit.get(context);
          return cubit.isTripInCart(trip) == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => const CartScreen(
                      //               isRoot: false,
                      //             )));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.Green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:  Text(
                      AppStrings.alreadyInCart,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      CartCubit.get(context).addToCart(trip);
                      CartCubit.get(context).getItems();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.Green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      AppStrings.boolNow,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
