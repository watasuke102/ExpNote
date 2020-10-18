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
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home : SplashScreen()
    );
  }
}
