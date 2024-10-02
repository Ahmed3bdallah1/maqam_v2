import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/features/trips/presentation/view/screens/details_screen.dart';

import '../../../../trips/models/trip_model.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.trip,
  });

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsScreen(trip: trip)));
      },
      child: Row(
        children: [
          SizedBox(
            width: 95,
            child: AspectRatio(
              aspectRatio: 0.98,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FancyShimmerImage(
                  imageUrl: trip.images[0],
                  boxFit: BoxFit.fitWidth,
                  errorWidget: Image.asset('assets/images/error.png'),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trip.name,
                style:  TextStyle(color: AppColors.Green, fontSize: 16,),
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}