/*
 * ExpNote - A simple household account book for Android
 * main.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'pages.dart';
import 'package:flutter/material.dart';

const APP_NAME         = 'ExpNote';
const VERSION          = 'v0.00';
const NAME_AND_VERSION = APP_NAME+' - '+VERSION;

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
  int _index   = 0;

  PageController _controller;

  @override void initState()
  {
    super.initState();
    _controller = new PageController();
  }
  @override void dispose()
  {
    super.dispose();
    _controller.dispose();
  }

  void _onPageChanged(int page)
  {
    setState( (){this._index = page;} );
  }

  void _onTapNavigation(int page)
  {
    _controller.animateToPage
    (
      page,
      duration: const Duration(microseconds: 500),
      curve: Curves.bounceOut
    );
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text(widget.title),
        actions:
        [
          IconButton
          (
            onPressed: null,
            tooltip: 'Settings',
            icon: Icon(Icons.settings)
          )
        ]
      ),
      body  : new PageView
      (
        controller   : _controller,
        onPageChanged: _onPageChanged,
        children:
        [
          new IventViewPage(),
          new CalanderPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar
      (
        currentIndex: _index,
        onTap: _onTapNavigation,
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
