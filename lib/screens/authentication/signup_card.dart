import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialx/screens/authentication/active_screen.dart';
import 'package:socialx/screens/authentication/login_card.dart';
import 'package:socialx/services/auth.dart';

import '../wrapper.dart';

class SignupCard extends StatefulWidget {
  const SignupCard({Key? key}) : super(key: key);

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final AuthService _auth = AuthService();
  String name = '';
  String password = '';
  String email = '';
  int? mobile;
  bool _checkPass = false;
  bool _showregbutton = true;
  String error = '';
  TextEditingController? _passController;
  final _formKey = GlobalKey<FormState>();
  bool _lockPass = true;
  bool changeColor = true;
  bool changeOther = false;
  double borderRadius = 32;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    'Create an \n Account',
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
                      hintText: "John Doe",
                      labelText: "Name",
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onChanged: ((val) {
                      setState(() {
                        name = val;
                      });
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter email",
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onChanged: ((val) {
                      setState(() {
                        email = val;
                      });
                    }),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter Mobile Number",
                      labelText: "Mobile Number",
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onChanged: ((val) {
                      setState(() {
                        mobile = int.parse(val);
                      });
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter mobile number";
                      } else if (value.trim().length < 10) {
                        return "Please enter valid mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _lockPass,
                    controller: _passController,
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: _checkPass,
                        onChanged: (value) {
                          setState(() {
                            _checkPass = value!;
                          });
                        },
                        isError: true,
                      ),
                      const Text('I agree with'),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'term & condition',
                            style:
                                TextStyle(color: Color.fromRGBO(255, 0, 0, 1)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an Account ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ActiveScreen(
                                          activeClass: LoginCard(),
                                        )));
                          },
                          child: const Text(
                            'Sign In!',
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
        const SizedBox(
          height: 25,
        ),
        if (_showregbutton)
          InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _showregbutton = false;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Wrapper()));
                });
                await _auth.sigup(name, email, password, mobile);
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 0, 0, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("Register",
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
