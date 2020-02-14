import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/view_models/chat_model.dart';
import 'package:letsattend/view_models/filterable_model.dart';
import 'package:letsattend/view_models/orderable_model.dart';
import 'package:letsattend/view_models/schedule_model.dart';
import 'package:letsattend/views/chat/chat_view.dart';
import 'package:letsattend/views/home/home.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/schedule/schedule_view.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';
import 'package:provider/provider.dart';

const String HomeRoute = '/';
const String SpeakersRoute = '/speakers';
const String ScheduleRoute = '/schedule';
const String NewsRoute = '/news';
const String ChatRoute = '/chat';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case SpeakersRoute:
      return MaterialPageRoute(builder: (context) => ChangeNotifierProvider<OrderableModel>(
        create: (context) => locator<OrderableModel>('speakers'),
        child: SpeakersView(),
      ));
    case ScheduleRoute:
      return MaterialPageRoute(builder: (context) => ChangeNotifierProvider<ScheduleModel>(
        create: (context) => locator<ScheduleModel>('schedule'),
        child: ScheduleView(),
      ));
    case NewsRoute:
      return MaterialPageRoute(builder: (context) => ChangeNotifierProvider<FilterableModel>(
        create: (context) => locator<FilterableModel>('news'),
        child: NewsView(),
      ));
    case ChatRoute:
      return MaterialPageRoute(builder: (context) => ChangeNotifierProvider<ChatModel>(
        create: (context) => locator<ChatModel>(),
        child: ChatView(),
      ));
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}