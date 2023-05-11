import 'package:flutter/material.dart';
import 'package:socialx/screens/authentication/active_screen.dart';
import 'package:socialx/screens/authentication/login_card.dart';
import 'package:socialx/screens/authentication/signup_card.dart';


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
    return showLogin?  const ActiveScreen( activeClass: LoginCard(),
    ): const SignupCard(
    );
  }
}