import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/view_models/orderable_model.dart';
import 'package:letsattend/view_models/schedule_model.dart';
import 'package:letsattend/views/home/home.dart';
import 'package:letsattend/views/schedule/schedule_view.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';
import 'package:provider/provider.dart';

const String HomeRoute = '/';
const String SpeakersRoute = '/speakers';
const String ScheduleRoute = '/schedule';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case SpeakersRoute:
      return MaterialPageRoute(builder: (context) => ChangeNotifierProvider<OrderableModel>(
        create: (context) => locator<OrderableModel>(),
        child: SpeakersView(),
      ));
    case ScheduleRoute:
      return MaterialPageRoute(builder: (context) => ChangeNotifierProvider<ScheduleModel>(
        create: (context) => locator<ScheduleModel>(),
        child: ScheduleView(),
      ));
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}