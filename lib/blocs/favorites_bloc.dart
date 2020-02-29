import 'dart:async' as UsersBloc;
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/favorites_service.dart';
import 'package:letsattend/services/users_service.dart';

class FavoritesBloc {

  final FavoritesService _service = locator<FavoritesService>();

  Future<bool> isFavorite(String eventKey) async {
    return _service.isFavorite(eventKey);
  }

  Future<void> setFavorite(String eventKey, bool value) async {
    return _service.setFavorite(eventKey, value);
  }

}
