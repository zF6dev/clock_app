import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 横向きで運用する
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ClockPage());
  }
}

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  late DateTime _now;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String year = (_now.year % 100).toString();
    String month = _now.month.toString();
    String day = _now.day.toString();
    const weekdays = ['', '月', '火', '水', '木', '金', '土', '日'];
    String weekday = weekdays[_now.weekday];
    String hour = _now.hour.toString();
    String minute = _now.minute.toString().padLeft(2, "0");
    String second = _now.second.toString().padLeft(2, "0");

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$hour:$minute:$second",
              style: TextStyle(color: Colors.white, fontSize: 80),
            ),
            Text(
              "$year/$month/$day($weekday)",
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
