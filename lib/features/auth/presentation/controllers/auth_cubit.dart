import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/auth/data/auth_repo.dart';
import 'package:maqam_v2/features/auth/model/user_model.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> login(BuildContext context,
      {required String email, required String password}) async {
    try {
      emit(LoginLoading());
      final user = await authRepo.login(email: email, password: password);

      emit(LoginSuccess(userCredential: user!.user));
    } catch (e) {
      String errorMessage = 'An error occurred, please check your credentials!';
      print("Error signing in with email and password: $e");
      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
          print('User not found. Please check your email.');
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
          print('Incorrect password. Please try again.');
        } else {
          errorMessage = 'An error occurred, please check your credentials!';
          print('An error occurred: ${e.message}');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      emit(LoginError(error: e.toString()));
      return null;
    }
  }

  Future<UserCredential?> register(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      emit(RegisterLoading());
      final user = await authRepo.createAccount(
          email: email, password: password, fullName: fullName);

      emit(RegisterSuccess(userCredential: user!));
      return user;
    } catch (e) {
      emit(RegisterError(error: e.toString()));
      return null;
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    try {
      emit(GetUserLoading());
      final user = await authRepo.getCurrentUserData();
      emit(GetUserSuccess(userModel: user!));
      return user;
    } catch (e) {
      print(e.toString());
      emit(GetUserError(error: e.toString()));
      return null;
    }
  }

  Future<UserModel?> getUserDataById({required String userId}) async {
    try {
      emit(GetUserLoading());
      final user = await authRepo.getUserDataById(userId: userId);
      emit(GetUserSuccess(userModel: user!));
      return user;
    } catch (e) {
      print(e.toString());
      emit(GetUserError(error: e.toString()));
      return null;
    }
  }

  bool userChecker() {
    if (FirebaseAuth.instance.currentUser!.isAnonymous == true) {
      emit(IsGuestTrue());
      return true;
    } else {
      emit(IsGuestFalse());
      return false;
    }
  }


}
