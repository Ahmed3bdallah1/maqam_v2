import 'package:flutter/material.dart';

class SeeAllLocationScreen extends StatefulWidget {
  const SeeAllLocationScreen({super.key});

  @override
  State<SeeAllLocationScreen> createState() => _SeeAllLocationScreenState();
}

class _SeeAllLocationScreenState extends State<SeeAllLocationScreen> {
@override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(
        child: Text('See All Location'),
      ),
    );
  }

}

