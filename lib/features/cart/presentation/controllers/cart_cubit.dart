import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/cart/data/cart_repo.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);

  Future<bool> addToCart(Trip trip) async {
    try {
      emit(AddLoading());
      final bool = await cartRepo.addToCart(trip);
      if (bool == true) {
        emit(AddSuccess());
        return true;
      } else {
        emit(AddError(error: "unable to add to the cart"));
        return false;
      }
    } catch (e) {
      emit(AddError(error: "unable to add to the cart ${e.toString()}"));
      return false;
    }
  }

  Future<bool> remove(Trip trip) async {
    try {
      emit(RemoveLoading());
      final bool = await cartRepo.removeFromCart(trip);
      if (bool == true) {
        emit(RemoveSuccess());
        return true;
      } else {
        emit(RemoveError(error: "unable to remove ${trip.name}"));
        return false;
      }
    } catch (e) {
      print(e);
      emit(RemoveError(error: "unable to remove ${trip.name}"));
      return false;
    }
  }

  Future<List<Trip>> getItems() async {
    emit(GetCartLoading());
    try {
      final cartList = await cartRepo.getCartItems();
      emit(GetCartSuccess(trips: cartList));
      return cartList;
    } catch (e) {
      print(e.toString());
      emit(GetCartError(error: e.toString()));
      return [];
    }
  }
}
