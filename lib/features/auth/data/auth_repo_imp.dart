import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/features/auth/data/auth_repo.dart';
import 'package:maqam_v2/features/auth/model/user_model.dart';

class AuthRepoImp extends AuthRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepoImp({required this.firebaseAuth, required this.firestore});

  @override
  Future<UserCredential?> createAccount({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // getting object from the user model
      UserModel user = UserModel(
          fullName: fullName,
          email: email,
          password: password,
          uid: firebaseAuth.currentUser!.uid);

      // stores the user data in firebase firestore docs
      await firestore
          .collection('user')
          .doc(firebaseAuth.currentUser!.uid)
          .set(user.toMap());

      return credential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return credential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final user = await firestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      final userData = UserModel.fromMap(user.data()!);
      return userData;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<UserModel?> getUserDataById({required String userId}) async {
    try {
      final user = await firestore.collection("users").doc(userId).get();

      final userData = UserModel.fromMap(user.data()!);
      return userData;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
