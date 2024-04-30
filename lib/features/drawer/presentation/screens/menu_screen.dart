import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import '../../../../../config/routes.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/drawer_item.dart';
import '../../../auth/presentation/controllers/auth_cubit.dart';
import '../../../auth/presentation/controllers/auth_state.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    final bool user = cubit.userChecker();
    return Scaffold(
      backgroundColor: Green,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Transform.rotate(
              angle: math.pi,
              child: Image.asset("assets/images/img3.png"),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 40,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/logo.png",
              color: Colors.green.shade800,
              height: 100,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 75,
              ),
              const DrawerItem(
                title: 'Home',
                icon: Icons.home,
                index: 0,
              ),
              const SizedBox(
                height: 10,
              ),
              const DrawerItem(
                title: 'Search',
                icon: Icons.search,
                index: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (user == true) {
                    return DrawerItem(
                      title: 'Cart',
                      icon: Icons.shopping_cart,
                      index: 2,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return CupertinoAlertDialog(
                                title: const Text("Unauthorized"),
                                content: const Text(
                                    "please login to access the cart"),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('close'),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.loginScreen);
                                    },
                                    child: const Text('Login'),
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  }
                  return const DrawerItem(
                    title: 'Cart',
                    icon: Icons.shopping_cart,
                    index: 2,
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (user == false) {
                    return DrawerItem(
                      title: 'Logout',
                      icon: Icons.logout,
                      index: 3,
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                    );
                  } else {
                    return DrawerItem(
                      title: 'Login',
                      icon: Icons.login_outlined,
                      index: 3,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.loginScreen);
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              const DrawerItem(
                  title: "Settings", icon: Icons.settings, index: 4)
            ],
          )
        ],
      ),
    );
  }
}
