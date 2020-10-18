/*
 * ExpNote - A simple household account book for Android
 * expDataList.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

//タイトル・日付，変動金額を記録するもの
class ExpData
{
  DateTime  date = DateTime.now();
  String   title = 'Title';
  int      money = 0;
  ExpData(){}
  ExpData.init(String t, int m, DateTime d)
  {
    title = t;
    date  = d;
    money = m;
  }

  ExpData.fromJson(Map j)
      : date = DateFormat('yyyy/MM/dd').parse(j['date']),
        title = j['title'],
        money = j['money'];

  Map toJson() =>
  {
    'date': DateFormat('yyyy/MM/dd').format(date),
    'title': title,
    'money': money
  };
}

class ExpDataList
{
  int _sumOfMoney     = 0;
  List<ExpData> _data = [];

  ExpDataList.data(this._data);

  ExpDataList(){}

  Future init() async
  {
    print("[debug] ExpDataList initing...");
    Future future=loadDataToSharedPreference();
    future.then((value) { for (var i in _data) _sumOfMoney += i.money; });
  }
  Future loadDataToSharedPreference() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getStringList('data');
    if (data != null)
      _data = data.map((f) => ExpData.fromJson(jsonDecode(f))).toList();
    else {
      print("[error] Failed data load (data:null)");
      _data = [];
    }
    print("\nLoad finish!!\n\n");
  }

  void clear()
  {
    _sumOfMoney = 0;
    _data.clear();
  }

  void add(ExpData d)
  {
    _data.add(d);
    _sumOfMoney += d.money;
    _data.sort((a, b) => b.date.compareTo(a.date));
    saveDataToSharedPreference();
  }
  Future saveDataToSharedPreference() async
  {
    var savedData = _data.map((f) => jsonEncode(f.toJson())).toList();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('data', savedData);

    print("\nSave finish!!\n\n");
  }


  int    sumOfData()  { return _data.length; }
  String sumOfMoney() { return NumberFormat("#,###")   .format(_sumOfMoney); }

  String   dateString(int i) { return DateFormat('yyyy/MM/dd').format(_data[i].date); }
  DateTime       date(int i) { return _data[i].date;  }
  String        title(int i) { return _data[i].title; }
  int           money(int i) { return _data[i].money; }

  String plusOrMinus(int i)
  {
    if (_data[i].money < 0)
      return "";
    return "+";
  }


  List<ExpData> getEventsOfAnyDay(DateTime tmp)
  {
    DateFormat fmt = DateFormat('yyyy/MM/dd');
    var date = fmt.format(tmp);
    List<ExpData> list = [];
    for (var i in _data) {
      if (date == fmt.format(i.date)) list.add(i);
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
              Text(plusOrMinus(index) + money(index).toString(),style: Theme.of(context).textTheme.headline3),
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
