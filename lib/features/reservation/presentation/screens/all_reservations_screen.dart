import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import 'package:maqam_v2/features/reservation/models/reservation_model.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../di_container.dart';

class AllReservationScreen extends StatelessWidget {
  const AllReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My Reservations", isRoot: false),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(color: AppColors.Green)),
                    const Gap(10),
                    Text(
                      AppStrings.pending,
                      style: TextStyle(
                          color: AppColors.Green, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Expanded(child: Divider(color: AppColors.Green)),
                  ],
                ),
              ),
              FutureBuilder<List<ReservationModel>>(
                future: sl<ReservationCubit>().reservations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: AppColors.Green.withOpacity(300),
                            highlightColor: AppColors.Green.withOpacity(100),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColors.Green.withOpacity(.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasData) {
                    final list = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (list!.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/img2.png",
                                  height: 200,
                                  color: Colors.green,
                                ),
                                const SizedBox(height: 20),
                                Flexible(
                                  child: Text(
                                    AppStrings.noReservations,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
        
                        final item = list[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Green.withOpacity(.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.Green),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(item.name.toUpperCase(),
                                          style: TextStyle(color: AppColors.Green, fontSize: 16)),
                                      const SizedBox(height: 5),
                                      Text(item.email,
                                          style: TextStyle(color: AppColors.Green, fontSize: 16)),
                                      const SizedBox(height: 5),
                                      Text(item.phoneNumber,
                                          style: TextStyle(color: AppColors.Green, fontSize: 16)),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text("Places: ",
                                              style: TextStyle(
                                                  color: AppColors.Green, fontSize: 16)),
                                          for (var i in item.cartItems)
                                            Text("$i, ",
                                                style: TextStyle(
                                                    color: AppColors.Green, fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(AppStrings.reserved,
                                              style: TextStyle(
                                                  color: AppColors.Green, fontSize: 16)),
                                          const SizedBox(width: 5),
                                          item.reserved == true
                                              ? const Icon(
                                                  Icons.circle,
                                                  color: Colors.green,
                                                )
                                              : const Icon(
                                                  Icons.circle_outlined,
                                                  color: Colors.green,
                                                )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    print(snapshot.error);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/error.png",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppStrings.unKnownError,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.Green,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(color: Colors.green)),
                    SizedBox(width: 10),
                    Text(
                      "Confirmed",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Divider(color: Colors.green)),
                  ],
                ),
              ),
              FutureBuilder<List<ReservationModel>>(
                future: sl<ReservationCubit>().acceptedReservations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.green[300]!,
                            highlightColor: Colors.green[100]!,
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColors.Green.withOpacity(.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasData) {
                    final list = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (list!.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/img2.png",
                                  height: 200,
                                  color: Colors.green,
                                ),
                                const SizedBox(height: 20),
                                const Flexible(
                                  child: Text(
                                    "There is no reservations accepted for now",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
        
                        final item = list[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.Green.withOpacity(.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.Green),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(item.name.toUpperCase(),
                                          style: TextStyle(color: AppColors.Green, fontSize: 16)),
                                      const SizedBox(height: 5),
                                      Text(item.email,
                                          style: TextStyle(color: AppColors.Green, fontSize: 16)),
                                      const SizedBox(height: 5),
                                      Text(item.phoneNumber,
                                          style: TextStyle(color: AppColors.Green, fontSize: 16)),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text("Places: ",
                                              style: TextStyle(
                                                  color: AppColors.Green, fontSize: 16)),
                                          for (var i in item.cartItems)
                                            Text("$i, ",
                                                style: TextStyle(
                                                    color: AppColors.Green, fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Reserved",
                                              style: TextStyle(
                                                  color: AppColors.Green, fontSize: 16)),
                                          const SizedBox(width: 5),
                                          item.reserved == true
                                              ? const Icon(
                                            Icons.circle,
                                            color: Colors.green,
                                          )
                                              : const Icon(
                                            Icons.circle_outlined,
                                            color: Colors.green,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    print(snapshot.error);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/error.png",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Something went wrong",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.Green,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
