/*
 * ExpNote - A simple household account book for Android
 * data.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'expDataList.dart';

const APP_NAME         = 'ExpNote';
const VERSION          = 'v2.0.0';
const NAME_AND_VERSION = APP_NAME+' - '+VERSION;

// アプリの設定の読み込み・書き込み関連
class SettingList
{
  bool   dark=false;
  String sortCriteria="money";
  String upOrDown="down";
  String tap="single";

  Future init(BuildContext context) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dark         = pref.getBool('darkMode');
    upOrDown     = pref.getString('upOrDown');
    sortCriteria = pref.getString('sortCriteria');
    DynamicTheme.of(context).changeTheme(dark);
  }

  Future changeTheme(BuildContext context) async
  {
    dark=!dark;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('darkMode', dark);
    DynamicTheme.of(context).changeTheme(dark);
  }

  Future setTap(String value) async
  {
    tap=value;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('tap', tap);
  }

  Future setUpOrDown(String value) async
  {
    upOrDown=value;
    expDataList.sort();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('upOrDown', upOrDown);
  }

  Future setSortCriteria(String value) async
  {
    sortCriteria=value;
    expDataList.sort();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('sortCriteria', sortCriteria);
  }
}
SettingList settings;


//テーマの動的変更
typedef ThemeBuilder=Widget Function(BuildContext context, ThemeData theme);
class DynamicTheme extends StatefulWidget
{
  ThemeBuilder builder;
  ThemeData theme=ThemeData
  (
    primaryColor          : Colors.lightGreen,
    secondaryHeaderColor  : Colors.lightGreen[50],
    primaryColorLight     : Colors.lightGreen[100],
    backgroundColor       : Colors.lightGreen[200],
    buttonColor           : Colors.lightGreen[300],
    accentColor           : Colors.lightGreen[500],
    toggleableActiveColor : Colors.lightGreen[600],
    primaryColorDark      : Colors.lightGreen[700],
  );

  DynamicTheme({Key key, this.builder}) : super(key: key);
  @override State<StatefulWidget> createState()=>DynamicThemeState();

  static DynamicThemeState of(BuildContext context)
  {
    return context.findAncestorStateOfType<State<DynamicTheme>>();
  }
}

class DynamicThemeState extends State<DynamicTheme>
{
  void changeTheme(bool dark)
  {
    widget.theme=ThemeData
    (
      brightness: dark      ? Brightness.dark : Brightness.light,
      primaryColor          : Colors.lightGreen,
      secondaryHeaderColor  : Colors.lightGreen[50],
      primaryColorLight     : Colors.lightGreen[100],
      backgroundColor       : Colors.lightGreen[200],
      buttonColor           : Colors.lightGreen[300],
      accentColor           : Colors.lightGreen[500],
      toggleableActiveColor : Colors.lightGreen[600],
      primaryColorDark      : Colors.lightGreen[700],
    );
    setState(()=>null);
  }

  @override Widget build(BuildContext context)
  {
    return widget.builder(context, widget.theme);
  }
}