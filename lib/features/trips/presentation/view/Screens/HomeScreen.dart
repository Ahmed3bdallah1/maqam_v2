import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';
import 'TripsScreen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: gray,
      ),
      backgroundColor: gray,
      body: CartScereen(),
    );
  }
}