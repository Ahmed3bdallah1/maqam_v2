import 'package:maqam_v2/features/trips/models/trip_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class AddSuccess extends CartState {}

class AddError extends CartState {
  final String error;

  AddError({required this.error});
}

class AddLoading extends CartState {}

class RemoveSuccess extends CartState {}

class RemoveError extends CartState {
  final String error;

  RemoveError({required this.error});
}

class RemoveLoading extends CartState {}

class GetCartSuccess extends CartState {
  final List<Trip> trips;

  GetCartSuccess({required this.trips});
}

class GetCartError extends CartState {
  final String error;

  GetCartError({required this.error});
}

class GetCartLoading extends CartState {}
