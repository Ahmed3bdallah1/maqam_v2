import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:maqam_v2/features/auth/data/auth_repo.dart';
import 'package:maqam_v2/features/auth/data/auth_repo_imp.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/cart/data/cart_repo.dart';
import 'package:maqam_v2/features/cart/data/cart_repo_imp.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/reservation/data/reservation_repo.dart';
import 'package:maqam_v2/features/reservation/data/reservation_repo_imp.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_cubit.dart';
import 'package:maqam_v2/features/search/data/search_repo.dart';
import 'package:maqam_v2/features/search/data/search_repo_imp.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_cubit.dart';
import 'package:maqam_v2/features/trips/data/trips_repo.dart';
import 'package:maqam_v2/features/trips/data/trips_repo_imp.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // externals
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => Connectivity());

  // register repos of the app
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(firebaseAuth: sl(), firestore: sl()));
  sl.registerLazySingleton<ReservationRepo>(
      () => ReservationRepoImp(auth: sl(), firestore: sl()));
  sl.registerLazySingleton<TripRepo>(() => TripRepoImp(firestore: sl()));
  sl.registerLazySingleton<CartRepo>(
      () => CartRepoImp(firestore: sl(), auth: sl()));
  sl.registerLazySingleton<SearchRepo>(
      () => SearchRepoImp(firestore: sl()));


  // register controllers of the app
  sl.registerFactory(() => TripsCubit(sl()));
  sl.registerFactory(() => ReservationCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => SearchCubit(sl()));
  sl.registerFactory(() => CartCubit(sl()));


}
