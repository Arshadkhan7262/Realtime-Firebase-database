

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/screens/dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:firebase_crud/screens/auth/user_login.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: FirebaseOptions(apiKey: 'AIzaSyCMpdwPpP3OJTmJV4u20csK_bSrgyApzg8', appId: '1:699016709061:android:27f2d15362d616733ec1ac', messagingSenderId: '699016709061', projectId: 'fir-crud-6f91f')
);

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth auth=FirebaseAuth.instance;

  final user=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    nextScreen();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent.shade400,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

         Center(
           child:  Lottie.asset('assets/animation/logo.json'),
         )



        ],
      ),

    );
  }
   nextScreen() {

    late Timer timer;
    if(user!=null)
      {
        timer=  Timer.periodic(Duration(seconds: 5), (timer) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
        });
      }
    else{
      timer=  Timer.periodic(Duration(seconds: 5), (timer) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UserLoginScreen()));
      });

    }

  }
}


