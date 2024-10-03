import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/trips/data/trips_repo.dart';
import 'package:maqam_v2/features/trips/models/location.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepo tripsRepo;

  TripsCubit(this.tripsRepo) : super(TripsInitial());

  // static TripsCubit get(BuildContext context) => BlocProvider.of(context);
  //
  // int currentIndex = 0;
  //
  // void changeTab(int value) {
  //   currentIndex = value;
  //   emit(ChangeNavigation());
  // }

  Stream<Iterable<Trip>> getTrips() {
    return tripsRepo.getTrips();
  }

  Stream<Iterable<Maqam>> getMaqam({required tripName}) {
    return tripsRepo.getMaqam(tripName);
  }

  Stream<Iterable<Trip>> getTripsByName({required String name}) {
    return tripsRepo.getTripsByName(name: name);
  }

  Future<List<LocationModel>> getLocation() {
    return tripsRepo.getLocations();
  }
}
