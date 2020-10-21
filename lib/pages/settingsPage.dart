/*
 * ExpNote - A simple household account book for Android
 * settingsPage.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:ExpNote/data.dart';
import 'package:flutter/material.dart';
import '../data.dart';

// Change Settings Page
class SettingsPage extends StatefulWidget
{
  final String title;
  SettingsPage( {Key key, this.title} ) : super(key: key);
  @override _SettingsPageState createState() => _SettingsPageState();
}

//SettingsPageState
class _SettingsPageState extends State<SettingsPage>
{
  @override
  void initState() {
    super.initState();
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(title: Text("Settings")),
      body: Padding
      (
        padding: EdgeInsets.all(15),
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>
          [
            Text("${settings.dark}"),
            FlatButton
            (
              onPressed: () {settings.changeTheme(context);},
              child: Text("change theme")
            )
          ],
        )
      )
    );
  }
}
