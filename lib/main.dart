import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(height: 40.0),
        TableCalendar(
          calendarController: _calendarController,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableCalendarFormats: const {
            CalendarFormat.month: '',
            CalendarFormat.week: '',
          },
          availableGestures: AvailableGestures.all,
          startDay: DateTime.utc(2020, 1, 1),
          endDay: DateTime.now(),
          formatAnimation: FormatAnimation.slide,
          calendarStyle: CalendarStyle(
            selectedColor: Colors.deepOrange[400],
            todayColor: Colors.blue[500],
            markersColor: Colors.brown[700],
            outsideDaysVisible: false,
          ),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
          ),
          onDaySelected: (date, events) {
            _onDaySelected(date, events);
            _animationController.forward(from: 0.0);
          },
          onVisibleDaysChanged: _onVisibleDaysChanged,
        ),
//        Expanded(
//          child: _buildList(),
//        )
      RaisedButton(
        onPressed: () {
          setState(() {
            _calendarController.toggleCalendarFormat();
          });
        },
        child: Text("show/hide"),
      )
      ],
    ));
  }

  Widget _buildList() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Event 1'),
          subtitle: Text("Subtitle 1 and there for"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Event 1'),
          subtitle: Text("Subtitle 1 and there for"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Event 1'),
          subtitle: Text("Subtitle 1 and there for"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Event 1'),
          subtitle: Text("Subtitle 1 and there for"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Event 1'),
          subtitle: Text("Subtitle 1 and there for"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Event 1'),
          subtitle: Text("Subtitle 1 and there for"),
        ),
      ],
    );
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    print('UTC: ${day.toUtc()}');
    print('day: $day');
    setState(() {});
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }
}
