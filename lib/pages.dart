/*
 * ExpNote - A simple household account book for Android
 *
 * pages.dart
 * 2020 Watasuke <watasuke102@gmail.com>
 */
import 'package:flutter/material.dart';

class IventViewPage extends StatefulWidget
{
  final String title;
  IventViewPage( {Key key, this.title} ) : super(key: key);
  @override _IventViewPageState createState() => _IventViewPageState();
}
//IventViewPageState
class _IventViewPageState extends State<IventViewPage>
{
  int _counter = 0;

  void _incrementCounter()
  {
    setState( (){_counter+=500;} );
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Column
      (
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>
        [
          Text('¥$_counter',style: Theme.of(context).textTheme.headline2)
        ],
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: _incrementCounter,
        tooltip  : 'Increment',
        child    : Icon(Icons.add),
      ),
    );
  }
}


// Calander View Page
class CalanderPage extends StatefulWidget
{
  final String title;
  CalanderPage( {Key key, this.title} ) : super(key: key);
  @override _CalanderPageState createState() => _CalanderPageState();
}
//CalanderPageState
class _CalanderPageState extends State<CalanderPage>
{
  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Column
      (
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>
        [
          Text('hogehoge')
        ],
      )
    );
  }
}