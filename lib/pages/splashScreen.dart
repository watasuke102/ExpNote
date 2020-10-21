/*
 * ExpNote - A simple household account book for Android
 * splashScreen.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'dart:async';

import 'package:ExpNote/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../expDataList.dart';
import '../data.dart';
import 'mainPage.dart';

//SplashScreen
class SplashScreen extends StatefulWidget
{
  SplashScreen( {Key key, this.title} ) : super(key: key);

  final String title;

  @override _SplashScreenState createState() => _SplashScreenState();
}

//SplashScreenState
class _SplashScreenState extends State<SplashScreen>
{
  bool timerFinished=false;
  @override void initState()
  {
    super.initState();
    initData(); startTimer();
  }

  void initData() async
  {
    settings.init(context);
    expDataList = ExpDataList();
    expDataList.init();
    if(timerFinished)
      goMainPage();
  }
  void startTimer() async
  {
    Timer(Duration(seconds: 1), ()
    {
      timerFinished=true;
      if(expDataList.initialized)
        goMainPage();
    });
  }
  void goMainPage()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage(title: APP_NAME)));
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold( body: Center(child: SvgPicture.asset('img/logo.svg')) );
  }
}
