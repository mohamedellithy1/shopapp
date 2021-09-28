import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/modules/on_boarding/onBoarding.dart';

class SplashScreen extends StatefulWidget {
  static final ROUTE_NAME='SplashScreen';

  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
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