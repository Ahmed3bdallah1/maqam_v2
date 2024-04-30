import 'dart:io';

import 'package:maqam_v2/features/reservation/models/reservation_model.dart';

abstract class ReservationState {}

class ReservationInitial extends ReservationState {}

class AddSuccess extends ReservationState {}

class AddError extends ReservationState {
  final String error;

  AddError({required this.error});
}

class AddLoading extends ReservationState {}

class GetReservationsSuccess extends ReservationState {
  final List<ReservationModel> reservations;

  GetReservationsSuccess({required this.reservations});
}

class GetReservationsError extends ReservationState {
  final String error;

  GetReservationsError({required this.error});
}

class GetReservationsLoading extends ReservationState {}

class PickFileLoading extends ReservationState {}

class PickFileSuccess extends ReservationState {
  final File file;

  PickFileSuccess({required this.file});
}

class PickFileFailure extends ReservationState {
  final String error;

  PickFileFailure({required this.error});
}
