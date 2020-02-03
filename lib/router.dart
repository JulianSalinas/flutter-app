import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/views/home/home.dart';
import 'package:letsattend/views/schedule/schedule_view.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';

const String HomeRoute = '/';
const String SpeakersRoute = '/speakers';
const String ScheduleRoute = '/schedule';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case SpeakersRoute:
      return MaterialPageRoute(builder: (context) => Speakers());
    case ScheduleRoute:
      return MaterialPageRoute(builder: (context) => Schedule());
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}