import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';


class Authenticate  extends StatefulWidget{
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin=true;
  void changeScreen(){
    setState(() {
      showLogin=!showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    return showLogin? const LoginPage(
      // onHarkt: changeScreen,
    ): const SignupPage(
      // onHarkt: changeScreen,
    );
  }
}