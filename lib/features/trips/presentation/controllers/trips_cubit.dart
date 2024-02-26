import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/trips/data/trips_repo.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepo tripsRepo;

  TripsCubit(this.tripsRepo) : super(TripsInitial());

  static TripsCubit get(BuildContext context) => BlocProvider.of(context);
}
