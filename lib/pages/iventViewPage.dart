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
import 'package:intl/intl.dart';
import 'addIventsPage.dart';

//タイトル・日付，変動金額を記録するもの
class _Data
{
  String title = 'Title';
  String date  = '1970/01/01';
  int    money = 0;
  _Data(String t, String d, int m)
  {
    title = t;
    date  = d;
    money = m;
  }
}

class _ExpDataList
{
  int _sumOfMoney=0;
  List<_Data> data=[];

  _ExpDataList()
  {
    print("[debug] _ExpDataList initing...");
    for(int i=0; i<1000; i++)
    {
      data.add(_Data('hoge($i)', '2020/10/10', i*25));
      _sumOfMoney += data[i].money;
    }
  }
  int    sumOfData() { return data.length;  }
  int    money(int i){ return data[i].money;}
  String sumOfMoney(){ return NumberFormat("#,###").format(_sumOfMoney);}
  String title(int i){ return data[i].title;}
  String date (int i){ return data[i].date ;}
  String plusOrMinus(int i)
  {
    if(data[i].money<0)
      return "-";
    return "+";
  }

  Widget card(BuildContext context, int index)
  {
    return Container(child:Card(child: Row
    (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>
      [
        Flexible(child: Column(children:<Widget>
        [
          Text
          (
            title(index),
            style   : Theme.of(context).textTheme.subtitle1,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ])),
        // 収支額・表示
        Column
        (
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>
          [
            Text(plusOrMinus(index)+money(index).toString(), style: Theme.of(context).textTheme.headline3),
            Text(date(index), style: Theme.of(context).textTheme.caption)
          ]
        )
      ]
    )));
  }
}


class IventViewPage extends StatefulWidget
{
  final String title;
  IventViewPage( {Key key, this.title} ) : super(key: key);
  @override _IventViewPageState createState() => _IventViewPageState();
}

//IventViewPageState
class _IventViewPageState extends State<IventViewPage>
{
  _ExpDataList expDataList=new _ExpDataList();
  @override Widget build(BuildContext context)
  {
    //expDataList = new _ExpDataList();
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
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddIventsPage()));
        }
      ),
    );
  }
}