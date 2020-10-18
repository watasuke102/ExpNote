/*
 * ExpNote - A simple household account book for Android
 * iventDetailPage.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';
import '../expDataList.dart';

// Ivent detail Page
class IventDetailPage extends StatelessWidget
{
  final ExpData data;
  IventDetailPage( {Key key, this.data} ) : super(key: key);

  @override Widget build(BuildContext context)
  {
    print(data);
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("イベントの詳細"),
      ),
    );
  }
}
