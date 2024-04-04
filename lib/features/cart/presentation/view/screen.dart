import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/cart/presentation/view/ReservationScreen.dart';
import 'package:maqam_v2/features/cart/presentation/view/widgets/cart_item.dart';

import '../../../../core/constants.dart';

class CartScreen extends StatefulWidget {
  final bool? isRoot;

  const CartScreen({super.key, this.isRoot});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final getter = CartCubit.get(context).getItems();
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final list = CartCubit.get(context).cartItems;
        return Scaffold(
          appBar:
              CustomAppBar(title: "Your Cart", isRoot: widget.isRoot ?? true),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: list.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/img2.png",
                          height: 200,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 20),
                        const Flexible(
                          child: Text(
                            "Your cart is empty please go back to main screen",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: Key(list[index].name),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            var itemToRemove = list[index];
                            list.removeAt(index);

                            CartCubit.get(context).remove(itemToRemove);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${itemToRemove.name} removed from cart'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Row(
                              children: [
                                Spacer(),
                                Icon(
                                  CupertinoIcons.trash,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          child: CartCard(cart: list[index]),
                        ),
                      );
                    },
                  ),
          ),
          bottomNavigationBar: list.isEmpty
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ReservationScreen(
                                    cartList: list,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Checkout Now",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
        );
      },
    );
  }
}
