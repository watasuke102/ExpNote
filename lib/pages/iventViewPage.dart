/*
 * ExpNote - A simple household account book for Android
 * iventViewPage.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';
import 'addIventsPage.dart';
import '../expDataList.dart';

class IventViewPage extends StatefulWidget
{
  final String title;
  IventViewPage( {Key key, this.title} ) : super(key: key);
  @override _IventViewPageState createState() => _IventViewPageState();
}

//IventViewPageState
class _IventViewPageState extends State<IventViewPage>
{
  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Padding
      (
        padding: EdgeInsets.all(10),
        // Main Widgets
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>
          [
            Center(child: Text('¥'+expDataList.sumOfMoney(),style: Theme.of(context).textTheme.headline2)),
            //Container(child:Center(
            Flexible(child: ListView.builder
            (
              itemCount: expDataList.sumOfData(),
              itemBuilder: (context, index)
              {
                return expDataList.card(context, index);
              }
            ))
          ]
        )
      ),

      //Add ivent button
      floatingActionButton: FloatingActionButton
      (
        tooltip  : 'Add',
        child    : Icon(Icons.add),
        onPressed: () async
        {
          await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddIventsPage()));
          setState(() {});
        }
      ),
    );
  }
}
