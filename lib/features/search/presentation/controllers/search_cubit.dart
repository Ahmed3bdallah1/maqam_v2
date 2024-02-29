import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/search/data/search_repo.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_state.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit(this.searchRepo) : super(SearchInitial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  Stream<Iterable<Trip>> streamTripsByName({required String name}) {
    return searchRepo.streamTripsByName(name: name);
  }
}
