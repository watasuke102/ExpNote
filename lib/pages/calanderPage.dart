/*
 * ExpNote - A simple household account book for Android
 * calanderPage.dart
 *
 * CopyRight (c) 2020 Watasuke
 * Email  : <watasuke102@gmail.com>
 * Twitter: @Watasuke102
 * This software is released under the MIT SUSHI-WARE License.
 */
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Padding
      (
        padding: EdgeInsets.all(15),
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>
          [
            Text('hogehoge'),
            TableCalendar
            (
              calendarController: _calendarController,
            )
          ],
        )
      )
    );
  }
}
