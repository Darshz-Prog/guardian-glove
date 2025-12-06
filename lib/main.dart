import 'package:flutter/material.dart';
import 'package:guardian/Screen/Map_Screen.dart';
import 'package:guardian/Screen/home_screen.dart';
import 'package:guardian/Screen/login_screen.dart';
import 'package:guardian/Widgets/my_theme.dart';
import 'package:guardian/firebase_options.dart';
import 'Screen/SoS_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:core';

const USE_DATABASE_EMULATOR = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guardian App',
      theme: my_theme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/Home': (context) => HomeScreen(),
        '/Map_Screen': (context) => MapScreen(),
        '/SoS_Screen': (context) => SosScreen(),
        // '/SoS_location': (context) {
        //   final cords =
        //       ModalRoute.of(context)?.settings.arguments
        //           as Map<dynamic, dynamic>?;
        //   print("Received args: ${ModalRoute.of(context)?.settings.arguments}");

        
        //   return SosLocation(cords: cords);
        // },
      },
    );
  }
}
