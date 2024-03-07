import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/features/auth/model/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginSuccess extends AuthState {
  final User? userCredential;

  LoginSuccess({this.userCredential});
}

class LoginError extends AuthState {
  final String error;

  LoginError({required this.error});
}

class LoginLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final UserCredential userCredential;

  RegisterSuccess({required this.userCredential});
}

class RegisterError extends AuthState {
  final String error;

  RegisterError({required this.error});
}

class RegisterLoading extends AuthState {}

class GetUserSuccess extends AuthState {
  final UserModel userModel;

  GetUserSuccess({required this.userModel});
}

class GetUserError extends AuthState {
  final String error;

  GetUserError({required this.error});
}

class GetUserLoading extends AuthState {}
class IsGuestTrue extends AuthState {}
class IsGuestFalse extends AuthState {}
