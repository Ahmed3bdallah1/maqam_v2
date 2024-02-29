import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maqam_v2/features/trips/data/trips_repo.dart';
import 'package:maqam_v2/features/trips/models/location.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';

class TripRepoImp extends TripRepo {
  final FirebaseFirestore firestore;

  TripRepoImp({required this.firestore});

  @override
  List<Trip> filterTrips(List<Trip> trips, String location) {
    List<Trip> filterTrips = [];
    for (int i = 0; i < trips.length; i++) {
      if (trips[i].location == location) {
        filterTrips.add(trips[i]);
      }
    }
    return filterTrips;
  }

  @override
  Stream<Iterable<Trip>> getTrips() {
    final controller = StreamController<Iterable<Trip>>();

    final sub = firestore.collection("trip").snapshots().listen((snapshot) {
      final trips = snapshot.docs.map(
        (tripData) => Trip.fromMap(
          tripData.data(),
        ),
      );
      controller.sink.add(trips);
    });

    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Stream<Iterable<Trip>> getTripsByName({required String name}) {
    final controller = StreamController<Iterable<Trip>>();

    final sub = firestore
        .collection("trip")
        .where("name", isGreaterThanOrEqualTo: name)
        .where("name", isLessThanOrEqualTo: "$name\uf8ff")
        .snapshots()
        .listen((snapshot) {
      final trips = snapshot.docs.map(
        (tripData) => Trip.fromMap(
          tripData.data(),
        ),
      );
      controller.sink.add(trips);
    });

    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Future<List<LocationModel>> getLocations() async {
    QuerySnapshot querySnapshot =
        await firestore.collection('locations').get();
    return querySnapshot.docs
        .map(
            (doc) => LocationModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
