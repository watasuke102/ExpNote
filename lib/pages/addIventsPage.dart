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
import 'package:intl/intl.dart';
import '../expDataList.dart';

// Add Ivents Page
class AddIventsPage extends StatefulWidget
{
  final String title;
  AddIventsPage( {Key key, this.title} ) : super(key: key);
  @override _AddIventsPageState createState() => _AddIventsPageState();
}

class _AddIventsPageState extends State<AddIventsPage>
{
  ExpData enteredData = ExpData();
  DateFormat fmt = DateFormat('yyyy/MM/dd');

  Future<void> selectDate(BuildContext context) async
  {
    final DateTime date=await showDatePicker
    (
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(3000)
    );
    setState((){ enteredData.date = date??DateTime.now(); });
  }

  void done()
  {
    expDataList.add(enteredData);
    Navigator.pop(context, false);
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Add Ivent"),
        actions:
        [
          IconButton(icon: Icon(Icons.check), onPressed: () => done())
        ],
      ),

      body: Padding
      (
        padding: EdgeInsets.all(10),
        child: Column
        (
          children: <Widget>
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
              [
                Text(fmt.format(enteredData.date), style: Theme.of(context).textTheme.headline5),
                FlatButton.icon
                (
                  color: Colors.lightBlue,
                  icon: Icon(Icons.calendar_today),
                  label: Text("変更"),
                  onPressed: () async => selectDate(context)
                )
              ]
            ),
            TextField
            (
              decoration: InputDecoration(labelText: "タイトル", hintText: "Title"),
              maxLines: null,
              onChanged: (value) { setState(() { enteredData.title=value; }); }
            ),
            TextField
            (
              decoration: InputDecoration(labelText: "金額"),
              keyboardType: TextInputType.number,
              onChanged: (value) { setState(() { enteredData.money = int.parse(value); }); }
            )
          ]
        )
      )
    );
  }
}
