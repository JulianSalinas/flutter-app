import 'package:flutter/material.dart';
import 'package:letsattend/page.dart';

import 'package:letsattend/view_models/collections/chat_model.dart';
import 'package:letsattend/view_models/collections/news_model.dart';
import 'package:letsattend/view_models/collections/schedule_model.dart';
import 'package:letsattend/view_models/collections/speakers_model.dart';
import 'package:letsattend/views/about/about_view.dart';

import 'package:letsattend/views/home/home.dart';
import 'package:letsattend/views/chat/chat_view.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/schedule/schedule_view.dart';
import 'package:letsattend/views/settings/setttings_view.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';

const String HomeRoute = '/';
const String ScheduleRoute = '/schedule';
const String SpeakersRoute = '/speakers';
const String NewsRoute = '/news';
const String ChatRoute = '/chat';
const String SettingsRoute = '/settings';
const String AboutRoute = '/about';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case SpeakersRoute:
      return RealtimePage<SpeakersModel>(SpeakersView());
    case ScheduleRoute:
      return RealtimePage<ScheduleModel>(ScheduleView());
    case NewsRoute:
      return RealtimePage<NewsModel>(NewsView());
    case ChatRoute:
      return RealtimePage<ChatModel>(ChatView());
    case SettingsRoute:
      return MaterialPageRoute(builder: (context) => SettingsView());
    case AboutRoute:
      return MaterialPageRoute(builder: (context) => AboutView());
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}