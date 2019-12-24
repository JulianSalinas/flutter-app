import 'package:flutter/material.dart';
import 'package:letsattend/shared/clock/clock_analog.dart';

class Clock extends StatelessWidget {

  final DateTime time;

  Clock(this.time);

  @override
  Widget build(BuildContext context) {

    return AnalogClock.dark (
      datetime: time,
      showTicks: true,
      showNumbers: true,
      showSecondHand: false,
      showDigitalClock: false,
    );

  }

}
