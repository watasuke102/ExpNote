/*
 * ExpNote - A simple household account book for Android
 *
 * 2020 Watasuke <watasuke102@gmail.com>
 */

import 'package:flutter/material.dart';

const APP_NAME        = 'ExpNote';
const VERSION         = 'v0.00';
const NAME_AND_VERSION = APP_NAME+VERSION;

void main() => runApp(MainApp());
/*
class data
{
}
*/
// MainApp
class MainApp extends StatelessWidget
{
  @override Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: NAME_AND_VERSION,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home : MainPage(title: APP_NAME)
    );
  }
}

//MainPage
class MainPage extends StatefulWidget
{
  MainPage( {Key key, this.title} ) : super(key: key);

  final String title;

  @override _MainPageState createState() => _MainPageState();
}

//MainPageState
class _MainPageState extends State<MainPage>
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
      appBar: AppBar(title: Text(widget.title)),
      body  : Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>
          [
            Text('¥$_counter',style: Theme.of(context).textTheme.headline2)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: _incrementCounter,
        tooltip  : 'Increment',
        child    : Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar
      (
        items:
        [
          BottomNavigationBarItem
          (
            icon : Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem
          (
            icon : Icon(Icons.calendar_today),
            label: 'Calender'
          ),
        ],
      )
    );
  }
}
