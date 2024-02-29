import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maqam_v2/features/search/data/search_repo.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';

class SearchRepoImp extends SearchRepo{
  final FirebaseFirestore firestore;

  SearchRepoImp({required this.firestore});
  @override
  Stream<Iterable<Trip>> streamTripsByName({required String name}) {
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

}