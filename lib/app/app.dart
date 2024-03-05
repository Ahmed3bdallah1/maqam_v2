import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/config/routes.dart';
import 'package:maqam_v2/di_container.dart' as di;
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/auth/presentation/view/login_screen.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/view/screens/drawer_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
        BlocProvider(create: (context) => di.sl<CartCubit>()),
        BlocProvider(create: (context) => di.sl<SearchCubit>()),
        BlocProvider(create: (context) => di.sl<TripsCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              return const DrawerPage();
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
