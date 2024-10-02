import 'package:flutter/material.dart';
import 'package:maqam_v2/core/constants.dart';

class HeadHomeTitle extends StatelessWidget {
  final String title;
  const HeadHomeTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.Green,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
