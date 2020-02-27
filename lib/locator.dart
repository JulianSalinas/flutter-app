import 'package:get_it/get_it.dart';
import 'package:letsattend/services/chat_service.dart';

import 'package:letsattend/services/news_service.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/auth/auth_firebase.dart';
import 'package:letsattend/services/users_service.dart';

import 'package:letsattend/blocs/users_bloc.dart';
import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/blocs/chat_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/blocs/speakers_bloc.dart';
import 'package:letsattend/blocs/schedule_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<UsersService>(() => UsersService());
  locator.registerFactory<UserBlocs>(() => UserBlocs());

  /// --- Theme management ---
  locator.registerLazySingleton(() => SettingsBloc());

  /// --- Auth management ---
  locator.registerFactory<AuthFirebase>(() => AuthFirebase());
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc());

  /// --- Speakers management ---
  locator.registerFactory<SpeakersBloc>(() => SpeakersBloc());
  locator.registerLazySingleton<SpeakersService>(() => SpeakersService());

  /// --- Schedule management ----
  locator.registerFactory<ScheduleBloc>(() => ScheduleBloc());
  locator.registerLazySingleton<EventsService>(() => EventsService());

  /// --- News management
  locator.registerFactory<NewsBloc>(() => NewsBloc());
  locator.registerFactory<NewsService>(() => NewsService());

  /// --- Chat management
  locator.registerFactory<ChatBloc>(() => ChatBloc());
  locator.registerFactory<ChatService>(() => ChatService());

}
