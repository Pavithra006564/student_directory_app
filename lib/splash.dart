import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_directory_app/home.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
  Future.delayed(Duration(seconds: 6),() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
  },);
    return Scaffold(
      body: Center(child:Lottie.asset("assets/Welcome.json"),),
    );
  }
}