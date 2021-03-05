

import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  
  scaffoldBackgroundColor: Colors.white,
  fontFamily: font,

  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.white,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: font
      )
    ),
    iconTheme: IconThemeData(color: Colors.black)  
  ),

);

const String font = 'Commissioner';