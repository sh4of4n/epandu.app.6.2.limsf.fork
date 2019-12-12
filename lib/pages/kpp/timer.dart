import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer _timer;
  int seconds;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(constructTime(seconds)),
    );
  }

  // Time formatting, converted to the corresponding hh:mm:ss format according to the total number of seconds
  String constructTime(int seconds) {
    int minute = 45;
    int second = 0;
    return formatTime(minute) + ":" + formatTime(second);
  }

  // Digital formatting, converting 0-9 time to 00-09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  @override
  void initState() {
    super.initState();
    // Get the current time
    var now = DateTime.now();
    // Get a 2-minute interval
    var twoHours = now.add(Duration(minutes: 2)).difference(now);
    // Get the total number of seconds, 2 minutes for 120 seconds
    seconds = twoHours.inSeconds;
    startTimer();
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        seconds--;
      });
      if (seconds == 0) {
        // Countdown seconds 0, cancel timer
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}
