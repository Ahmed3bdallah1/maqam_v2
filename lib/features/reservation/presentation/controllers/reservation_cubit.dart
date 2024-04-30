import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maqam_v2/features/reservation/data/reservation_repo.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_state.dart';

import '../../models/reservation_model.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepo reservationRepo;

  ReservationCubit(this.reservationRepo) : super(ReservationInitial());

  File? file;

  static ReservationCubit get(BuildContext context) => BlocProvider.of(context);

  Future<bool> addReservation(ReservationModel reservationModel) async {
    print("object");
    try {
      emit(AddLoading());
      final bool = await reservationRepo.addReservation(reservationModel);
      if (bool == true) {
        emit(AddSuccess());
        const SnackBar(
          content: Text('reservation submitted successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 10),
        );
        print("success");
        return true;
      } else {
        const SnackBar(
          content: Text('unable to add to reservation'),
          backgroundColor: Colors.red,
        );
        emit(AddError(error: "unable to add reservation"));
        return false;
      }
    } catch (e) {
      emit(AddError(error: "unable to add to reservation"));
      return false;
    }
  }

  Future<List<ReservationModel>> reservations() async {
    try {
      emit(GetReservationsLoading());
      final list = await reservationRepo.reservations();
      if (list.isNotEmpty) {
        print("success");
        emit(GetReservationsSuccess(reservations: list));
        return list;
      } else {
        emit(GetReservationsError(error: "No reservations found"));
        return [];
      }
    } catch (e) {
      print(e.toString());
      emit(GetReservationsError(error: "unable to fetch to reservation"));
      return [];
    }
  }

  Future<File?> pickImage() async {
    emit(PickFileLoading());
    File? image;
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
    );

    if (file != null) {
      image = File(file.path);
      emit(PickFileSuccess(file: image));
    } else {
      emit(PickFileFailure(error: "file is empty"));
    }

    return image;
  }
}
