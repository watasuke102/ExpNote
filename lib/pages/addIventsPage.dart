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

  InputDecoration titleField, moneyField;

  @override void initState()
  {
    super.initState();
    titleField = InputDecoration(labelText: "タイトル*");
    moneyField = InputDecoration(labelText: "金額*");
    enteredData.title="";
    enteredData.money=null;
  }

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
    bool failed=false;
    if(enteredData.title == "")
    {
      failed=true;
      setState(()
      {
        titleField = InputDecoration(labelText: "タイトル*", errorText: "必須項目です");
      });
    }
    else titleField = InputDecoration(labelText: "タイトル*");
    if(enteredData.money == null)
    {
      failed=true;
      setState(()
      {
        moneyField = InputDecoration(labelText: "金額*", errorText: "必須項目です（マイナスと整数のみ入力してください）");
      });
    }
    else moneyField = InputDecoration(labelText: "金額*");

    if(failed) return;
    expDataList.add(enteredData);
    Navigator.pop(context, false);
  }

  Widget dialog(BuildContext context)
  {
    return AlertDialog
    (
      title: Text("警告", style: Theme.of(context).textTheme.headline5),
      content: Text("変更は破棄されます。\n本当に前の画面に戻りますか？"),
      actions:
      [
        FlatButton(onPressed:(){ Navigator.pop(context,false); }, child: Text("キャンセル")),
        FlatButton(onPressed:(){ Navigator.pop(context,true ); }, child: Text("OK"))
      ],
    );
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("イベントの追加"),
        actions:
        [
          IconButton(icon: Icon(Icons.check), onPressed: () => done())
        ],
      ),

      body: WillPopScope
      (
        onWillPop:() async
        {
          //なにか入力されていたらダイアログ表示
          if
          (
            enteredData.title       != ""   ||
            enteredData.money       != null ||
            enteredData.description != ""
          )
            return showDialog<bool>(context: context, builder: (context) => dialog(context))?? false;

          return true;
        },
        child: Padding
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
                    color: Theme.of(context).buttonColor,
                    icon:  Icon(Icons.calendar_today,color: Colors.black),
                    label: Text("変更", style: TextStyle(color: Colors.black)),
                    onPressed: () async => selectDate(context)
                  )
                ]
              ),

              // タイトル
              TextField
              (
                decoration: titleField,
                maxLines: null,
                onChanged: (value) { setState(() { enteredData.title=value; }); }
              ),

              // 金額
              TextField
              (
                decoration: moneyField,
                keyboardType: TextInputType.number,
                onChanged: (value) { setState(()
                {
                  try{ enteredData.money = int.parse(value); }
                  catch(ex){ enteredData.money=null; }
                });}
              ),

              // 詳細
              TextField
              (
                decoration: InputDecoration(labelText: "詳細・メモ", hintText: "\n\n\n", hintMaxLines: 5),
                maxLines: null,
                onChanged: (value) { setState(() { enteredData.description=value; }); }
              ),
            ]
          )
        )
      )
    );
  }
}
