import 'package:flutter/material.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import 'package:maqam_v2/features/trips/presentation/view/screens/trips_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Maqam", isRoot: true),
      body: TripsScreen(),
    );
  }
}