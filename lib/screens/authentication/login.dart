import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:socialx/screens/authentication/forgotpassword.dart';
import 'package:socialx/screens/authentication/signup.dart';
import 'package:socialx/screens/authentication/signup_new.dart';

import '../../services/auth.dart';

typedef ChangeScreen = void Function();

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool changestate = false;
  bool _lockPass = true;
  bool _showlogbutton = true;
  String error = '';
  bool errorOcr = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  

  _LoginPageState();
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
                left: 35,
                right: 35,
                bottom: 0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter email",
                        labelText: "Email"),
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
                    height: 20.0,
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular((10.0))),
                      hintText: "Enter Password",
                      labelText: "Password",
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
                      return null;
                    },
                  ),
                   const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                      child: const Text("Forget Password ?",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          )),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>const ForgotPassword()));
                      }),

                  const SizedBox(
                    height: 20,
                  ),
                  _showlogbutton
                      ? InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              setState(() {
                                _showlogbutton = false;
                              });
                              dynamic result =
                                  await _auth.login(email, password);

                              switch (result) {
                                case 'invalid-email':
                                  error = "Email is inValid";
                                  setState(() {
                                    _showlogbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case 'user-disabled':
                                  error = "User Disabled";
                                  setState(() {
                                    _showlogbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case 'user-not-found':
                                  error = "User not found";
                                  setState(() {
                                    _showlogbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case 'wrong-password':
                                  error = "Wrong Password";
                                  setState(() {
                                    _showlogbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case'too-many-requests':
                                   error = "Too many Request,try again Later ";
                                  setState(() {
                                    _showlogbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                default:
                                
                              }
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: const Duration(seconds: 1),
                            width: changestate ? 50 : 130,
                            height: 40,
                            // ignore: sort_child_properties_last
                            child: changestate
                                ? const Icon(Icons.done)
                                : const Text("LOGIN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white)),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: BorderRadius.circular(
                                    changestate ? 50 : 8)),
                          ),
                        )
                      : const CircularProgressIndicator(),

                  // ElevatedButton(
                  //   child: Text("Login"),
                  //   style: TextButton.styleFrom(minimumSize: Size(150, 40)),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                  //   },
                  // )
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                      child: const Text("Don't have account? SignUp",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue,
                          )),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                      }),
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
