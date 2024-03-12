import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/Homepage.dart';
import 'package:my_app/auth/login.dart';
import 'package:my_app/auth/registre.dart';
import 'package:my_app/categories/add.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[50],
              titleTextStyle: const TextStyle(
                  color: Colors.orange,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.orange))),
      /*if your account created  and verified can access to homepage and stay 
       signed until you sign out or if not you will be in login page  */
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const Homepage()
          : const login_page(),
      routes: {
        "registre": (context) => const registrePage(),
        "login": (context) => const login_page(),
        "homepage": (context) => const Homepage(),
        "addcategory": (context) => const AddCategory(),
      },
    );
  }
}
