import 'package:flutter/material.dart';







const kAppTitleNameStyle = TextStyle(
  color: Colors.blue,
  fontFamily: 'New Athena Unicode',
  fontSize: 65.0,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(10.0, 10.0),
      blurRadius: 3.0,
      color: Colors.lightBlue,
    ),
    Shadow(
      offset: Offset(10.0, 10.0),
      blurRadius: 8.0,
      color: Colors.grey,
    ),
  ],
);

const kAppTitleNameStyleAppBar = TextStyle(
  color: Colors.black,
  fontFamily: 'New Athena Unicode',
  fontSize: 20.0,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(10.0, 10.0),
      blurRadius: 3.0,
      color: Colors.black26,
    ),
    Shadow(
      offset: Offset(10.0, 10.0),
      blurRadius: 8.0,
      color: Colors.black26,
    ),
  ],
);

const webScreenSize = 600;

ThemeData appThemes = ThemeData(
  //Primary App Color
  primaryColor: Colors.white60,
  appBarTheme: const AppBarTheme(color: Colors.white10),

  //Background color of Scaffold
  scaffoldBackgroundColor: Colors.grey,

);


// 0xff657c88