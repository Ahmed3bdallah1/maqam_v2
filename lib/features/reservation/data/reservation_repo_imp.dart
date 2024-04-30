import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/features/reservation/data/reservation_repo.dart';
import 'package:maqam_v2/features/reservation/models/reservation_model.dart';
import 'package:uuid/uuid.dart';

class ReservationRepoImp extends ReservationRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ReservationRepoImp({required this.firestore, required this.auth});

  @override
  Future<bool> addReservation(reservationModel) async {
    final String id = const Uuid().v1();
    try {
      await firestore
          .collection("reservation")
          .doc(id)
          .set(reservationModel.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<ReservationModel>> reservations() async {
    try {
      final querySnapshot = await firestore
          .collection("reservation")
          .where("uid", isEqualTo: auth.currentUser!.uid).where("reserved",isEqualTo: false)
          .get();

      List<ReservationModel> reservationList = [];

      print(querySnapshot.size);
      for (var doc in querySnapshot.docs) {
        ReservationModel reservation = ReservationModel.fromMap(doc.data());
        reservationList.add(reservation);
      }
      print(reservationList.length);
      return reservationList;
    } catch (e) {
      print("==========error========");
      print(e);
      return [];
    }
  }
  @override
  Future<List<ReservationModel>> acceptedReservations() async {
    try {
      final querySnapshot = await firestore
          .collection("reservation")
          .where("uid", isEqualTo: auth.currentUser!.uid).where("reserved",isEqualTo: true)
          .get();

      List<ReservationModel> reservationList = [];

      print(querySnapshot.size);
      for (var doc in querySnapshot.docs) {
        ReservationModel reservation = ReservationModel.fromMap(doc.data());
        reservationList.add(reservation);
      }
      print(reservationList.length);
      return reservationList;
    } catch (e) {
      print("==========error========");
      print(e);
      return [];
    }
  }
}
