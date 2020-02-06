import 'package:get_it/get_it.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/services/stream_service.dart';
//import 'package:letsattend/services/news_service.dart';
import 'package:letsattend/view_models/auth_model.dart';
//import 'package:letsattend/view_models/news_model.dart';
import 'package:letsattend/view_models/schedule_model.dart';
import 'package:letsattend/view_models/stream_model.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/view_models/orderable_model.dart';
import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/view_models/navigation_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton(() => ThemeModel());
  locator.registerLazySingleton(() => AuthModel());

  locator.registerFactory<OrderableModel>(() => OrderableModel<SpeakersService>());
  locator.registerLazySingleton<SpeakersService>(() => SpeakersService());

  locator.registerFactory<ScheduleModel>(() => ScheduleModel());
  locator.registerLazySingleton<EventsService>(() => EventsService());

//  locator.registerFactory(() => NewsModel());
//  locator.registerLazySingleton(() => NewsService());

  locator.registerLazySingleton(() => NavigationModel());

}