import 'package:get_it/get_it.dart';
import 'package:letsattend/controllers/auth_controller.dart';

import 'package:letsattend/controllers/theme_controller.dart';
import 'package:letsattend/controllers/speakers_controller.dart';
import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/services/auth_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {

  locator.registerLazySingleton(() => ThemeController());
  locator.registerLazySingleton(() => AuthController());

  locator.registerFactory(() => SpeakersController());
  locator.registerLazySingleton(() => SpeakersService());

}