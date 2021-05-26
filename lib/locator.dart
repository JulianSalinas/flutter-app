import 'package:get_it/get_it.dart';

import 'package:letsattend/services/chat_service.dart';
import 'package:letsattend/services/news_service.dart';
import 'package:letsattend/services/users_service.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/services/favorites_service.dart';
import 'package:letsattend/services/auth_with_firebase.dart';

import 'package:letsattend/blocs/auth_bloc.dart';
import 'package:letsattend/blocs/chat_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/blocs/users_bloc.dart';
import 'package:letsattend/blocs/speakers_bloc.dart';
import 'package:letsattend/blocs/schedule_bloc.dart';
import 'package:letsattend/blocs/settings_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  /// --- Theme management ---
  locator.registerFactory<SettingsBloc>(() => SettingsBloc());

  /// --- Auth management ---
  locator.registerFactory<AuthWithFirebase>(() => AuthWithFirebase());
  locator.registerFactory<AuthBloc>(() => AuthBloc());

  /// --- Users management ---
  locator.registerFactory<UserBloc>(() => UserBloc());
  locator.registerLazySingleton<UsersService>(() => UsersService());

  /// --- Speakers management ---
  locator.registerFactory<SpeakersBloc>(() => SpeakersBloc());
  locator.registerFactory<SpeakersService>(() => SpeakersService());

  /// --- Schedule management ----
  locator.registerFactory<ScheduleBloc>(() => ScheduleBloc());
  locator.registerFactory<EventsService>(() => EventsService());
  locator.registerLazySingleton<FavoritesService>(() => FavoritesService());

  /// --- News management
  locator.registerFactory<NewsBloc>(() => NewsBloc());
  locator.registerFactory<NewsService>(() => NewsService());

  /// --- Chat management
  locator.registerFactory<ChatBloc>(() => ChatBloc());
  locator.registerFactory<ChatService>(() => ChatService());

}
