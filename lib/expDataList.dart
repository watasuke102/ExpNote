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
  DateTime date        = DateTime.now();
  DateTime createDate  = DateTime.now();
  int      money       = 0;
  String   title       = 'Title';
  String   description = '';

  String dateString(){ return DateFormat('yyyy/MM/dd').format(date); }

  ExpData(){}

  ExpData.fromJson(Map j)
      : date        = DateFormat('yyyy/MM/dd').parse(j['date']),
        createDate  = DateFormat('yyyy/MM/dd  HH:MM').parse(j['createDate']),
        title       = j['title'],
        money       = j['money'],
        description = j['description'];

  Map toJson() =>
  {
    'date': DateFormat('yyyy/MM/dd').format(date),
    'createDate': DateFormat('yyyy/MM/dd  HH:MM').format(createDate),
    'title': title,
    'money': money,
    'description': description
  };
}

class ExpDataList
{
  int _sumOfMoney     = 0;
  List<ExpData> _data = [];
  bool initialized    = false;

  ExpDataList.data(this._data);

  ExpDataList(){}

  Future init() async
  {
    print("[debug] ExpDataList initing...");
    _sumOfMoney = 0;
    Future future=loadDataToSharedPreference();
    future.then((value) { for (var i in _data) _sumOfMoney += i.money; initialized=true; });
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

  Future add(ExpData d)
  {
    d.createDate=DateTime.now();
    _data.add(d);
    _sumOfMoney += d.money;
    _data.sort((a, b) => b.date.compareTo(a.date));
    Future future=saveDataToSharedPreference();
    return future;
  }
  Future saveDataToSharedPreference() async
  {
    var savedData = _data.map((f) => jsonEncode(f.toJson())).toList();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('data', savedData);

    print("\nSave finish!!\n\n");
  }

  Future delete(int index)
  {
    _data.removeAt(index);
    Future future=saveDataToSharedPreference();
    return future;
  }

  Future updateData(int index, ExpData data)
  {
    _data[index] = data;
    Future future=saveDataToSharedPreference();
    return future;
  }


  int    sumOfData()  { return _data.length; }
  String sumOfMoney() { return NumberFormat("#,###").format(_sumOfMoney); }

  String   dateString(int i) { return _data[i].dateString(); }
  DateTime       date(int i) { return _data[i].date;  }
  String        title(int i) { return _data[i].title; }
  int           money(int i) { return _data[i].money; }

  String      description(int i) { return _data[i].description;}
  String createDateString(int i)
  {
    return DateFormat('yyyy/MM/dd  HH:MM').format(_data[i].createDate);
  }

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
    return Container( child:Card
    (
      child:Padding
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
        ))
      )
    );
  }
}

// This is very very bad (?) global class :(
ExpDataList expDataList;
