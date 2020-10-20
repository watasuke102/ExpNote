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
import 'package:intl/intl.dart';
import '../expDataList.dart';

// Ivent detail Page
class IventDetailPage extends StatefulWidget
{
  final int index;
  IventDetailPage( {Key key, this.index} ) : super(key: key);
  @override _IventDetailPageState createState() => _IventDetailPageState();
}

//IventViewPageState
class _IventDetailPageState extends State<IventDetailPage>
{
  ExpData enteredData = ExpData();
  DateFormat fmt = DateFormat('yyyy/MM/dd');

  InputDecoration titleField, moneyField;
  TextEditingController titleController, moneyController, descriptionController;

  @override void initState()
  {
    super.initState();
    enteredData.date  = expDataList.date(widget.index);
    // タイトル
    titleField        = InputDecoration(labelText: "タイトル*");
    enteredData.title = expDataList.title(widget.index);
    titleController   = TextEditingController(text: expDataList.title(widget.index));
    // 金額
    moneyField        = InputDecoration(labelText: "金額*");
    enteredData.money = expDataList.money(widget.index);
    moneyController   = TextEditingController(text: expDataList.money(widget.index).toString());
    // 詳細
    enteredData.description = expDataList.description(widget.index);
    descriptionController   = TextEditingController(text: expDataList.description(widget.index));
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
    Future future=expDataList.updateData(widget.index, enteredData);
    future.then((value) {future=expDataList.init();});
    future.then((value) {Navigator.pop(context, false);});
  }

  Widget dialog(BuildContext context, String title, String content)
  {
    return AlertDialog
    (
      title: Text(title, style: Theme.of(context).textTheme.headline5),
      content: Text(content),
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
        title: Text("イベントの詳細・編集"),
        actions:
        [
          IconButton(icon: Icon(Icons.check), onPressed: () => done())
        ],
      ),

      body: WillPopScope
      (
        onWillPop:() async
        {
          if
          (
            enteredData.title       != expDataList.title(widget.index) ||
            enteredData.money       != expDataList.money(widget.index) ||
            enteredData.description != expDataList.description(widget.index)
          )
          return showDialog<bool>
          (
            context: context,
            builder: (context) => dialog(context, "警告", "変更は破棄されます。\n本当に前の画面に戻りますか？")
          )?? false;
          return true;
        },
        child: Padding
        (
          padding: EdgeInsets.all(10),
          child: Column
          (
            children: <Widget>
            [
              Text("作成日: ${expDataList.createDateString(widget.index)}"),
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
                controller: titleController,
                decoration: titleField,
                maxLines: null,
                onChanged: (value) { setState(() { enteredData.title=value; }); }
              ),

              // 金額
              TextField
              (
                controller: moneyController,
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
                controller: descriptionController,
                decoration: InputDecoration(labelText: "詳細・メモ", hintText: "\n\n\n", hintMaxLines: 5),
                maxLines: null,
                onChanged: (value) { setState(() { enteredData.description=value; }); }
              ),
            ]
          )
        )
      ),

      floatingActionButton: IconButton
      (
        icon: Icon(Icons.delete),
        onPressed: () async
        {
          bool f=await showDialog<bool>
          (
            context: context,
            builder: (context) => dialog(context, "警告", "このイベントを削除しますか？\nこの変更は取り消すことが出来ません。")
          )?? false;
          if(f)
          {
            Future future=expDataList.delete(widget.index);
            future.then((value) => {future=expDataList.init()});
            future.then((value) => {Navigator.pop(context)});
          }
        },
      )
    );
  }
}
