import 'package:get_it/get_it.dart';
import 'package:letsattend/services/realtime/chat_service.dart';

import 'package:letsattend/services/realtime/news_service.dart';
import 'package:letsattend/services/storage/events_service.dart';
import 'package:letsattend/services/storage/speakers_service.dart';
import 'package:letsattend/services/auth/auth_firebase.dart';
import 'package:letsattend/services/users.dart';

import 'package:letsattend/view_models/user_model.dart';
import 'package:letsattend/view_models/auth/auth_model.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:letsattend/view_models/collections/chat_model.dart';
import 'package:letsattend/view_models/collections/news_model.dart';
import 'package:letsattend/view_models/collections/speakers_model.dart';
import 'package:letsattend/view_models/collections/schedule_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<UsersService>(() => UsersService());
  locator.registerFactory<UserModel>(() => UserModel());

  /// --- Theme management ---
  locator.registerLazySingleton(() => SettingsModel());

  /// --- Auth management ---
  locator.registerFactory<AuthFirebase>(() => AuthFirebase());
  locator.registerLazySingleton<AuthModel>(() => AuthModel());

  /// --- Speakers management ---
  locator.registerFactory<SpeakersModel>(() => SpeakersModel());
  locator.registerLazySingleton<SpeakersService>(() => SpeakersService());

  /// --- Schedule management ----
  locator.registerFactory<ScheduleModel>(() => ScheduleModel());
  locator.registerLazySingleton<EventsService>(() => EventsService());

  /// --- News management
  locator.registerFactory<NewsModel>(() => NewsModel());
  locator.registerLazySingleton<NewsService>(() => NewsService());

  /// --- Chat management
  locator.registerFactory<ChatModel>(() => ChatModel());
  locator.registerFactory<ChatService>(() => ChatService());

}
