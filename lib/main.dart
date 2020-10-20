/*
 * ExpNote - A simple household account book for Android
 * main.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';
import 'pages/splashScreen.dart';
import 'data.dart';

void main() => runApp(MainApp());

// MainApp
class MainApp extends StatelessWidget
{
  @override Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: NAME_AND_VERSION,
      theme: ThemeData
      (
        brightness: Brightness.dark,
        primaryColor            : Colors.lightGreen,
        secondaryHeaderColor    : Colors.lightGreen[50],
        primaryColorLight       : Colors.lightGreen[100],
        backgroundColor         : Colors.lightGreen[200],
        buttonColor             : Colors.lightGreen[300],
        accentColor             : Colors.lightGreen[500],
        toggleableActiveColor   : Colors.lightGreen[600],
        primaryColorDark        : Colors.lightGreen[700],
      ),
      home : SplashScreen()
    );
  }
}
