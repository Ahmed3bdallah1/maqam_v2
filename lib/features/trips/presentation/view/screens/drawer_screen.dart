import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maqam_v2/app/home_screen.dart';
import 'package:maqam_v2/config/routes.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/widgets/drawer_item.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_state.dart';
import 'package:maqam_v2/features/search/presentation/view/search_screen.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripsCubit, TripsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final index = TripsCubit.get(context).currentIndex;
          return ZoomDrawer(
            isRtl: false,
            duration: const Duration(milliseconds: 250),
            controller: zoomDrawerController,
            style: DrawerStyle.style3,
            menuScreen: const MenuScreen(),
            mainScreen: [
              const HomeScreen(),
              const SearchScreen(),
              const SizedBox(),
            ][index],
            mainScreenTapClose: false,
            borderRadius: 70.0,
            showShadow: true,
            angle: 0,
            menuBackgroundColor: Green,
            slideWidth: MediaQuery.of(context).size.width * 0.75,
          );
        });
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return Scaffold(
      backgroundColor: Green,
      body: Column(
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
              if (cubit.isGuest == true) {
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
                            content:
                                const Text("please login to access the cart"),
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
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (cubit.isGuest == false) {
                return DrawerItem(
                  title: 'Logout',
                  icon: Icons.logout,
                  index: 4,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                );
              } else {
                return DrawerItem(
                  title: 'Login',
                  icon: Icons.login_outlined,
                  index: 4,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.loginScreen);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
