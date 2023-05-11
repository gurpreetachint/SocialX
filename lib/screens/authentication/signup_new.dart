import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // TextEditingController dateCtl = TextEditingController();
  final AuthService _auth=AuthService();
  String name = '';
  String password = '';
  String email = '';
  int? mobile;
  final bool _validPass = false;
  bool _showregbutton=true;
  String error = '';
  TextEditingController? _passController;
  final _formKey = GlobalKey<FormState>();
  bool _lockPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('SocialX'),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
      ),
      body: Container(
        color: const Color.fromRGBO(190, 190, 190, 1),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 0, 0, 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    child: const Text('Login'),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 0, 0, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                    child: const Text('Signup'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 2,
              margin: const EdgeInsets.all(5),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 24, right: 24),
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
                          color:  Color.fromRGBO(255, 0, 0, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10.0)),
                            hintText: "John Doe",
                            labelText: "Name",
                          labelStyle: TextStyle(color:  Color.fromRGBO(255, 0, 0, 1),
                          ),

                        ),
                        onChanged: ((val) {
                          setState(() {
                            name = val;
                          });
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter email",
                            labelText: "Email"),
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter Mobile Number",
                            labelText: "Mobile Number"),
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
                        // validator: (value) {
                        //   if (!_validPass) {
                        //     return "Please enter valid password";
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _showregbutton? InkWell(
                        onTap: () async{
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            setState(() {
                              _showregbutton=false;
                            });
                            dynamic result=await _auth.sigup(name, email, password, mobile);


                            switch (result) {
                              case 'invalid-email':
                                error = "Email is inValid";
                                setState(() {
                                  _showregbutton = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                break;
                              case 'email-already-in-use':
                                error = "Email already exists try login";
                                setState(() {
                                  _showregbutton = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                break;
                              case 'operation-not-allowed':
                                error = "Operation not allowed";
                                setState(() {
                                  _showregbutton = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                break;
                              case 'weak-password:':
                                error = "Weak Password";
                                setState(() {
                                  _showregbutton = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                break;
                              case'too-many-requests':
                                error = "Too many Request,try again Later ";
                                setState(() {
                                  _showregbutton = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                break;

                              default:

                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                      ):const CircularProgressIndicator(),
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 40,
                      //   width: 150,
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: const Text("Register",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 20,
                      //           color: Colors.white)),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
