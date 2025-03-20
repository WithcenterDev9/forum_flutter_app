import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forum_firebase_app/firebase_options.dart';
import 'package:forum_firebase_app/router_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: routerConfig);
  }
}
