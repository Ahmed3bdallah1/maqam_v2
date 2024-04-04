import 'package:flutter/material.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/features/trips/presentation/view/screens/details_screen.dart';

import '../../../../trips/models/trip_model.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.cart,
  });

  final Trip cart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsScreen(trip: cart)));
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
                child: Image.network(cart.images[0]),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.name,
                style:  TextStyle(color: Green, fontSize: 16,),
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}