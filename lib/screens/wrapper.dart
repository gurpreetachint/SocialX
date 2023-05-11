import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './home/home.dart';
import 'authentication/authenticate.dart';


class Wrapper extends StatefulWidget{
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    
    super.initState();
    // screen();
  }
  @override
  Widget build(BuildContext context) {
    final user=context.watch<User?>();
    
   
      if(user==null){
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: unrelated_type_equality_checks
      home: const Authenticate(),
      routes: {
        'home': (context) =>  const Home(),
        
        
      },
    );
    }else{
      print(user.uid.toString());
      
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: unrelated_type_equality_checks
      home:const Home(),
      routes: {
        // 'doctorregistration': (context) => const DoctorRegistrationPage(),
        'home': (context) =>  const Home(),
        
        
      },
    );
    }
   
    
    
    
    
  }
}