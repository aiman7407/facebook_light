import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'constants.dart';

ThemeData kDarkTheme=ThemeData(
    scaffoldBackgroundColor: Color(0xff333739),
    primarySwatch: kDefaultColor,

    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff333739),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(

            statusBarIconBrightness: Brightness.light ,
            statusBarColor: Color(0xff333739)
        ),

        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kDefaultColor,
        elevation: 20,
        backgroundColor: Color(0xff333739),
        unselectedItemColor: Colors.grey
    ),

    textTheme: TextTheme(
      subtitle1: TextStyle(
          height: 1.3,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
        bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black
        )
    ),
    fontFamily: 'jannah'
);

ThemeData kLightTheme=ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: kDefaultColor,

    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(

            statusBarIconBrightness: Brightness.dark ,
            statusBarColor: Colors.white
        ),
        color: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kDefaultColor,
        elevation: 20,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey
    ),
    textTheme: TextTheme(
      subtitle1:  TextStyle(
        height: 1.3,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
        bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black
        )
    ),
    fontFamily: 'jannah'
);