import 'package:get_it/get_it.dart';
import 'package:letsattend/view_models/auth_model.dart';
import 'package:letsattend/view_models/schedule_model.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/view_models/speakers_model.dart';
import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/view_models/navigation_model.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {

  locator.registerLazySingleton(() => ThemeModel());
  locator.registerLazySingleton(() => AuthModel());

  locator.registerFactory(() => SpeakersModel());
  locator.registerLazySingleton(() => SpeakersService());

  locator.registerFactory(() => ScheduleModel());
  locator.registerLazySingleton(() => ScheduleModel());

  locator.registerLazySingleton(() => NavigationModel());

}