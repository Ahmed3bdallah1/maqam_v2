import '../models/reservation_model.dart';

abstract class ReservationRepo {
  Future<bool> addReservation(ReservationModel reservationModel);

  Future<List<ReservationModel>> reservations();

  Future<List<ReservationModel>> acceptedReservations();
}
