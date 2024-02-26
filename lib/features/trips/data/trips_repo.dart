import 'package:maqam_v2/features/trips/models/trip_model.dart';

abstract class TripRepo{
  Stream<Iterable<Trip>> getTrips();
  Stream<Iterable<Trip>> getTripsByName({required String name});
  List<Trip> filterTrips(List<Trip> trips, String location);
}