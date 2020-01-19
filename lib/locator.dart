import 'package:get_it/get_it.dart';
import 'package:letsattend/core/services/theme_service.dart';
import 'package:letsattend/core/services/database/firebase_service.dart';
import 'package:letsattend/core/services/auth/firebase_auth_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => ThemeService());
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerLazySingleton(() => FirebaseAuthService());
}