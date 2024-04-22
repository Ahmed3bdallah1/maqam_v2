import 'package:maqam_v2/features/trips/models/trip_model.dart';

abstract class CartRepo {
  Future<bool> addToCart(Trip trip);

  Future<bool> removeFromCart(Trip trip);
  Future<bool> removeAllCartItems();

  Future<List<Trip>> getCartItems();
}
