import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialx/screens/authentication/login_card.dart';
import 'package:socialx/screens/authentication/signup_card.dart';

import 'screens/wrapper.dart';
import 'services/auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SocialX());
}

class SocialX extends StatelessWidget {
  const SocialX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signup' : (context) => const SignupCard(),
        '/login' : (context) => const LoginCard(),
      },
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(255, 0, 0, 1),
      )),
      home: Scaffold(
        body: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return const Text('Something Went Wrong');
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return StreamProvider<User?>.value(
                  value: AuthService().user,
                  initialData: null,
                  child: const Wrapper(),
                );
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
