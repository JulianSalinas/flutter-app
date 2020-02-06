import 'package:get_it/get_it.dart';

import 'package:letsattend/services/news_service.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/services/auth/firebase_auth_service.dart';

import 'package:letsattend/view_models/auth_model.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/view_models/schedule_model.dart';
import 'package:letsattend/view_models/orderable_model.dart';
import 'package:letsattend/view_models/filterable_model.dart';
import 'package:letsattend/view_models/navigation_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  /// --- Theme management ---
  locator.registerLazySingleton(() => ThemeModel());

  locator.registerFactory<FirebaseAuthService>(() => FirebaseAuthService());
  locator.registerLazySingleton<AuthModel>(() => AuthModel());

  /// --- Speakers management ---
  locator.registerFactory<OrderableModel>(
    () => OrderableModel<SpeakersService>(),
    instanceName: 'speakers',
  );

  locator.registerLazySingleton<SpeakersService>(() => SpeakersService());

  /// --- Schedule management ----
  locator.registerFactory<ScheduleModel>(
    () => ScheduleModel(),
    instanceName: 'schedule',
  );

  locator.registerLazySingleton<EventsService>(() => EventsService());

  /// --- News management
  locator.registerFactory<FilterableModel>(
    () => FilterableModel<NewsService>(),
    instanceName: 'news',
  );

  locator.registerLazySingleton<NewsService>(() => NewsService());

  /// --- Navigation management
  locator.registerLazySingleton(() => NavigationModel());

}
