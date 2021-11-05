import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopapp/layout/shop_layout/Home_Layout.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/modules/on_boarding/onBoarding.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
class SplashScreen extends StatefulWidget {
  static final ROUTE_NAME='SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShopCubit.get(context)..getHomeData()..getFavoritesData()..getSettingProfile()..getCateogries();
    Timer(Duration(seconds: 3), () {
      if (onBoarding != null) {
        if (token != null)
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeLayout()));
        else
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ShopLoginScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OnBoarding()));
      }
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