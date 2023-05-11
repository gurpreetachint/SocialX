import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialx/screens/authentication/login_card.dart';
import 'package:socialx/screens/authentication/signup_card.dart';

class ActiveScreen extends StatefulWidget {
  const ActiveScreen({Key? key, required this.activeClass}) : super(key: key);
  final Widget activeClass;

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  String error = '';
  bool changeColor = true;
  bool changeOther = false;
  double borderRadius = 32;
  late Widget temporaryScreen;
  @override
  void initState() {
    temporaryScreen = widget.activeClass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text('SocialX'),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.775 / 2,
          color: const Color.fromRGBO(190, 190, 190, 1),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(borderRadius),
                        bottomLeft: Radius.circular(borderRadius))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          changeColor = true;
                          changeOther = false;
                          temporaryScreen = const LoginCard();
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1 / 2,
                        height: 65,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            color: changeColor != false
                                ? const Color.fromRGBO(255, 0, 0, 1)
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(borderRadius),
                                bottomRight: Radius.circular(borderRadius))),
                        child: const Center(child: Text('Login')),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          changeColor = false;
                          changeOther = true;
                          temporaryScreen = const SignupCard();
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width * 1 / 2,
                        height: 65,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: changeOther != false
                              ? const Color.fromRGBO(255, 0, 0, 1)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              bottomRight: Radius.circular(borderRadius)),
                        ),
                        child: const Center(child: Text('Signup')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              temporaryScreen,
            ],
          ),
        ),
      ),
    );
  }
}
