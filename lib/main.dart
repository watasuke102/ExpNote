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

const APP_NAME         = 'ExpNote';
const VERSION          = 'v0.00';
const NAME_AND_VERSION = APP_NAME+' - '+VERSION;

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
