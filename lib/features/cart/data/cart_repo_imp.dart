import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/features/cart/data/cart_repo.dart';
import 'package:maqam_v2/features/reservation/models/reservation_model.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';
import 'package:uuid/uuid.dart';

class CartRepoImp extends CartRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartRepoImp({required this.firestore, required this.auth});

  @override
  Future<bool> addToCart(Trip trip) async {
    try {
      await firestore
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("cart")
          .doc("${trip.name}&${trip.location}")
          .set(trip.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<Trip>> getCartItems() async {
    try {
      final data = await firestore
          .collection("user")
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .get();

      final tripList =
          data.docs.map((doc) => Trip.fromMap(doc.data())).toList();
      return tripList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<bool> removeFromCart(Trip trip) async {
    try {
      await firestore
          .collection("user")
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc("${trip.name}&${trip.location}")
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeAllCartItems() async {
    try {
      await firestore
          .collection("user")
          .doc(auth.currentUser!.uid)
          .collection("cart");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
