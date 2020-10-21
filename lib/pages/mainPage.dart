/*
 * ExpNote - A simple household account book for Android
 * mainPage.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';

import 'iventViewPage.dart';
import 'settingsPage.dart';
import 'calanderPage.dart';

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
  int _index = 0;
  PageController _controller;

  @override void initState()
  {
    super.initState();
    _controller = new PageController();
  }
  @override void dispose()
  {
    _controller.dispose();
    super.dispose();
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
            onPressed:() async
            {
              await Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
              setState(()=>null);
            },
            tooltip: 'Settings',
            icon: Icon(Icons.settings)
          )
        ]
      ),
      body: new PageView
      (
        controller   : _controller,
        onPageChanged:(value)
        {
          setState( (){this._index = value;} );
        },
        children:
        [
          new IventViewPage(),
          new CalanderPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar
      (
        currentIndex: _index,
        onTap:(value)
        {
          setState(()
          {
            _index=value;
            _controller.animateToPage
            (
              value,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuart,
            );
          });
        },
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
