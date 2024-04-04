import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/cart/data/cart_repo.dart';
import 'package:maqam_v2/features/cart/models/reservation_model.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/trips/models/trip_model.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);

  List<Trip> cartItems = [];

  Future<bool> addToCart(Trip trip) async {
    try {
      emit(AddLoading());
      final bool = await cartRepo.addToCart(trip);
      if (bool == true) {
        emit(AddSuccess());
        print("success");
        const SnackBar(
          content: Text('item has been added successfully'),
          backgroundColor: Colors.green,
        );
        return true;
      } else {
        emit(AddError(error: "unable to add to the cart"));
        const SnackBar(
          content: Text('unable to add to the cart'),
          backgroundColor: Colors.red,
        );
        return false;
      }
    } catch (e) {
      emit(AddError(error: "unable to add to the cart ${e.toString()}"));
      return false;
    }
  }

  Future<bool> addReservation(ReservationModel reservationModel) async {
    print("object");
    try {
      emit(AddLoading());
      final bool = await cartRepo.addReservation(reservationModel);
      if (bool == true) {
        emit(AddSuccess());
        const SnackBar(
          content: Text('reservation submitted successfully'),
          backgroundColor: Colors.green,
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

  Future<bool> removeAllCart() async {
    print("entered");
    try {
      emit(RemoveLoading());
      final bool = await cartRepo.removeAllCartItems();
      if (bool == true) {
        emit(RemoveSuccess());
        return true;
      } else {
        emit(RemoveError(error: "unable to remove"));
        return false;
      }
    } catch (e) {
      print(e);
      emit(RemoveError(error: "unable to remove"));
      return false;
    }
  }

  Future<List<Trip>> getItems() async {
    emit(GetCartLoading());
    try {
      cartItems = await cartRepo.getCartItems();
      emit(GetCartSuccess(trips: cartItems));
      return cartItems;
    } catch (e) {
      print(e.toString());
      emit(GetCartError(error: e.toString()));
      return cartItems;
    }
  }

  bool isTripInCart(Trip tripToCheck) {
    return cartItems.any((tripInCart) => tripInCart.name == tripToCheck.name);
  }
}
