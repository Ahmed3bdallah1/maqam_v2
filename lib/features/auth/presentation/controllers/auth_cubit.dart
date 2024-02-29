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

  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      emit(LoginLoading());
      final user = await authRepo.login(email: email, password: password);

      emit(LoginSuccess(userCredential: user!));
      return user;
    } catch (e) {
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
}
