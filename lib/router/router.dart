import 'package:flutter/material.dart';
import 'package:letsattend/router/routes.dart';
import 'package:letsattend/router/synched_page.dart';

import 'package:letsattend/blocs/chat_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/blocs/schedule_bloc.dart';
import 'package:letsattend/blocs/speakers_bloc.dart';

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

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return SynchedPage<NewsBloc>(HomeView());
      case Routes.authRoute:
        return MaterialPageRoute(builder: (context) => AuthView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => SignInView());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (context) => SignUpView());
      case Routes.speakersRoute:
        return SynchedPage<SpeakersBloc>(SpeakersView());
      case Routes.scheduleRoute:
        return SynchedPage<ScheduleBloc>(ScheduleView());
      case Routes.newsRoute:
        return SynchedPage<NewsBloc>(NewsView());
      case Routes.chatRoute:
        return SynchedPage<ChatBloc>(ChatView());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (context) => SettingsView());
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (context) => AboutView());
      case Routes.passwordResetRoute:
        return MaterialPageRoute(builder: (context) => PasswordResetView());
      default:
        return SynchedPage<NewsBloc>(HomeView());
    }
  }
}
