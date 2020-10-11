/*
 * ExpNote - A simple household account book for Android
 * addIventsPage.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';

// Add Ivents Page
class AddIventsPage extends StatefulWidget
{
  final String title;
  AddIventsPage( {Key key, this.title} ) : super(key: key);
  @override _AddIventsPageState createState() => _AddIventsPageState();
}

class _AddIventsPageState extends State<AddIventsPage>
{
  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Add Ivent"),
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10),
        child: Text("Add Ivent"),
      )
    );
  }
}
