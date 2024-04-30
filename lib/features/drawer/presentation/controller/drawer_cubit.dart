import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerPageState> {
  DrawerCubit() : super(DrawerInitial());

  static DrawerCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeTab(int value) {
    currentIndex = value;
    emit(ChangeNavigation());
  }
}
