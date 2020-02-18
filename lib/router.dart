import 'package:flutter/material.dart';

import 'package:letsattend/page.dart';
import 'package:letsattend/views/home/home.dart';
import 'package:letsattend/views/auth/sign_in.dart';
import 'package:letsattend/views/auth/sign_up.dart';
import 'package:letsattend/views/chat/chat_view.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/about/about_view.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';
import 'package:letsattend/views/schedule/schedule_view.dart';
import 'package:letsattend/views/settings/setttings_view.dart';

import 'package:letsattend/view_models/collections/chat_model.dart';
import 'package:letsattend/view_models/collections/news_model.dart';
import 'package:letsattend/view_models/collections/schedule_model.dart';
import 'package:letsattend/view_models/collections/speakers_model.dart';

class Router {

  static const String HOME_ROUTE = '/';
  static const String LOGIN_ROUTE = '/login';
  static const String SIGN_ROUTE = '/signUp';
  static const String SCHEDULE_ROUTE = '/schedule';
  static const String SPEAKERS_ROUTE = '/speakers';
  static const String NEWS_ROUTE = '/news';
  static const String CHAT_ROUTE = '/chat';
  static const String SETTINGS_ROUTE = '/settings';
  static const String ABOUT_ROUTE = '/about';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (context) => Home());
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (context) => SignIn());
      case SIGN_ROUTE:
        return MaterialPageRoute(builder: (context) => SignUp());
      case SPEAKERS_ROUTE:
        return RealtimePage<SpeakersModel>(SpeakersView());
      case SCHEDULE_ROUTE:
        return RealtimePage<ScheduleModel>(ScheduleView());
      case NEWS_ROUTE:
        return RealtimePage<NewsModel>(NewsView());
      case CHAT_ROUTE:
        return RealtimePage<ChatModel>(ChatView());
      case SETTINGS_ROUTE:
        return MaterialPageRoute(builder: (context) => SettingsView());
      case ABOUT_ROUTE:
        return MaterialPageRoute(builder: (context) => AboutView());
      default:
        return MaterialPageRoute(builder: (context) => Home());
    }

  }

}
