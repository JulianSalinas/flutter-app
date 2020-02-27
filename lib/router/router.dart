import 'package:flutter/material.dart';
import 'package:letsattend/router/synched_page.dart';
import 'package:letsattend/router/routes.dart';
import 'package:letsattend/views/auth/sign_in.dart';
import 'package:letsattend/views/auth/sign_up.dart';
import 'package:letsattend/views/auth/auth_view.dart';
import 'package:letsattend/views/auth/password_reset.dart';

import 'package:letsattend/views/home/home_view.dart';
import 'package:letsattend/views/chat/chat_view.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/about/about_view.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';
import 'package:letsattend/views/schedule/schedule_view.dart';
import 'package:letsattend/views/settings/setttings_view.dart';

import 'package:letsattend/blocs/chat_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/blocs/schedule_bloc.dart';
import 'package:letsattend/blocs/speakers_bloc.dart';

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME_ROUTE:
        return SynchedPage<NewsBloc>(HomeView());
      case Routes.AUTH_ROUTE:
        return MaterialPageRoute(builder: (context) => AuthView());
      case Routes.LOGIN_ROUTE:
        return MaterialPageRoute(builder: (context) => SignInView());
      case Routes.SIGN_UP_ROUTE:
        return MaterialPageRoute(builder: (context) => SignUpView());
      case Routes.SPEAKERS_ROUTE:
        return SynchedPage<SpeakersBloc>(SpeakersView());
      case Routes.SCHEDULE_ROUTE:
        return SynchedPage<ScheduleBloc>(ScheduleView());
      case Routes.NEWS_ROUTE:
        return SynchedPage<NewsBloc>(NewsView());
      case Routes.CHAT_ROUTE:
        return SynchedPage<ChatBloc>(ChatView());
      case Routes.SETTINGS_ROUTE:
        return MaterialPageRoute(builder: (context) => SettingsView());
      case Routes.ABOUT_ROUTE:
        return MaterialPageRoute(builder: (context) => AboutView());
      case Routes.PASSWORD_RESET_ROUTE:
        return MaterialPageRoute(builder: (context) => PasswordResetView());
      default:
        return SynchedPage<NewsBloc>(HomeView());
    }
  }
}
