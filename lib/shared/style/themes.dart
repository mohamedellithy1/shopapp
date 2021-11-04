import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/shared/style/color.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor
    ),
    scaffoldBackgroundColor: HexColor('333737'),
    appBarTheme: AppBarTheme(color: Colors.grey, elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333737'),
            statusBarIconBrightness: Brightness.light
        ),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
            bodyText2: TextStyle(
                fontSize: 15,
                color: Colors.black
            )
        )

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor('333737'),
        selectedLabelStyle: TextStyle(fontSize: 15),
        selectedIconTheme: IconThemeData(
            size: 35
        )
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        bodyText2: TextStyle(
            fontSize: 15,
            color: Colors.white
        )
    )
);
ThemeData lightTheme =  ThemeData(
    primarySwatch: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor
    ),
    scaffoldBackgroundColor: Colors.white   ,
    appBarTheme: AppBarTheme(color: Colors.white, elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white10,
            statusBarIconBrightness: Brightness.dark
        ),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20,
        selectedLabelStyle: TextStyle(fontSize: 15),
        selectedIconTheme: IconThemeData(
            size: 35
        )
    )
);
