import 'package:maqam_v2/features/trips/models/trip_model.dart';

abstract class SearchRepo{
  Stream<Iterable<Trip>> streamTripsByName({required String name});
}