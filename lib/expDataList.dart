/*
 * ExpNote - A simple household account book for Android
 * expDataList.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//タイトル・日付，変動金額を記録するもの
class ExpData
{
  DateTime date  = DateTime.now();
  String   title = 'Title';
  int      money = 0;
  ExpData(){}
  ExpData.init(String t, int m, DateTime d)
  {
    title = t;
    date  = d;
    money = m;
  }
}

class ExpDataList
{
  int _sumOfMoney=0;
  List<ExpData> _data=[];

  ExpDataList.data(this._data);
  ExpDataList()
  {
    print("[debug] ExpDataList initing...");
  }
  void clear()
  {
    _sumOfMoney = 0;
    _data.clear();
  }
  void add(ExpData d){ _data.add(d); }


  int      sumOfData() { return _data.length;  }
  String   sumOfMoney(){ return NumberFormat("#,###").format(_sumOfMoney);}

  int      money(int i)    { return _data[i].money;}
  String   title(int i)    { return _data[i].title;}
  DateTime date (int i)    { return _data[i].date ;}

  String   dateString(int i)
  {
    DateFormat fmt = DateFormat('yyyy/MM/dd');
    return fmt.format(_data[i].date);
  }

  String   plusOrMinus(int i)
  {
    if(_data[i].money<0)
      return "-";
    return "+";
  }

  List<ExpData> getEventsOfAnyDay(DateTime tmp)
  {
    DateFormat fmt = DateFormat('yyyy/MM/dd');
    var date=fmt.format(tmp);
    List<ExpData> list=[];
    for (var i in _data)
    {
      if(date == fmt.format(i.date))
        list.add(i);
    }
    return list;
  }


  Widget card(BuildContext context, int index)
  {
    return Container(child:Card(child:Padding
    (
      padding: EdgeInsets.only(left: 8,right: 5),
      child: Row
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
              Text(dateString(index), style: Theme.of(context).textTheme.caption)
            ]
          )
        ]
      )))
    );
  }
}
// This is very very bad (?) global class :(
ExpDataList expDataList;
