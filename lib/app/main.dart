import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maqam_v2/di_container.dart'as di;
import 'package:maqam_v2/firebase_options.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}
