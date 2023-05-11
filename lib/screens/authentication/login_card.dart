import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:socialx/screens/authentication/active_screen.dart';
import 'package:socialx/screens/authentication/signup_card.dart';
import 'package:socialx/screens/wrapper.dart';
import 'package:socialx/services/auth.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final AuthService _auth = AuthService();
  String password = '';
  String email = '';
  bool _showlogbutton = true;
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool _lockPass = true;
  bool changeColor = true;
  bool changeOther = false;
  double borderRadius = 32;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 69.7,
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.only(left: 12, right: 12),
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SignIn into your \n Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 0, 0, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter email",
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      } else if (!(EmailValidator.validate(value))) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _lockPass,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: _lockPass
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _lockPass = !(_lockPass);
                          });
                        },
                      ),
                      hintText: "Enter Password",
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid password";
                      }
                      if (value.length < 8) {
                        return "Password is too weak";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password',
                            style:
                                TextStyle(color: Color.fromRGBO(255, 0, 0, 1)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don"t have an Account ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ActiveScreen(
                                        activeClass: SignupCard())));
                          },
                          child: const Text(
                            'Register Now!',
                            style:
                                TextStyle(color: Color.fromRGBO(255, 0, 0, 1)),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 6,
        ),
        if (_showlogbutton)
          InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _showlogbutton = false;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Wrapper()));
                });

                await _auth.login(email, password);
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 0, 0, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
            ),
          )
        else
          const CircularProgressIndicator(),
      ],
    );
  }
}
