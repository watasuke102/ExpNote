/*
 * ExpNote - A simple household account book for Android
 * settingsPage.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../expDataList.dart';
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
      body: SingleChildScrollView(child: Padding
      (
        padding: EdgeInsets.all(15),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>
          [
            // テーマ
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Icon(Icons.palette,size: 40),
                Text("テーマの変更",style: Theme.of(context).textTheme.headline4)
              ]
            ),
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text("ダークテーマを有効にする"),
                Switch(value: settings.dark, onChanged: (value) =>settings.changeTheme(context)),
              ]
            ),
            Text("${settings.dark}"),
                FlatButton
                (
              onPressed: () {settings.changeTheme(context);},
              child: Text("change theme")
            )

            //終わり
          ],
        )
      ))
    );
  }
}
