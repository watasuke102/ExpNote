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
  Widget dialog(BuildContext context)
  {
    return AlertDialog
    (
      title: Text("警告", style: Theme.of(context).textTheme.headline5),
      content: Text("本当に全てのイベントを削除しますか？\nこの操作は取り消せません。"),
      actions:
      [
        FlatButton(onPressed:(){ Navigator.pop(context,false); }, child: Text("キャンセル")),
        FlatButton(onPressed:(){ Navigator.pop(context,true ); }, child: Text("OK", style: TextStyle(color: Colors.red),))
      ],
    );
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

            Container(height: 80),

            // データリセット
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Icon(Icons.delete, size: 40),
                Text("データのリセット",style: Theme.of(context).textTheme.headline4)
              ]
            ),
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text("全てのイベントを削除します"),
                FlatButton
                (
                  color: Colors.red[300],
                  child: Text("実行"),
                  onPressed:()
                  {
                    if(showDialog<bool>(context: context, builder: (context) => dialog(context))??false)
                      expDataList.clearAll();
                  }
                ),
              ]
            ),
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
