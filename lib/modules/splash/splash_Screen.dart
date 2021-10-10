import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopapp/modules/on_boarding/onBoarding.dart';
class SplashScreen extends StatefulWidget {
  static final ROUTE_NAME='SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OnBoarding()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image/splash.png',
                height: MediaQuery.of(context).size.height,),
            ],
          ),
        );
      }
}