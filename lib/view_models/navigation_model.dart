import 'package:flutter/material.dart';

class NavigationModel with ChangeNotifier {

  String _current = '/';

  get current => _current;

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> pushReplacement(String routeName, {dynamic arguments}) {
    return _navigateTo(
      routeName,
      navigatorKey.currentState.pushReplacementNamed,
    );
  }

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return _navigateTo(routeName, navigatorKey.currentState.pushNamed);
  }

  Future<dynamic> _navigateTo(String routeName, Function push, {arguments}) {
    if (_current == routeName) return Future.value(routeName);
    _current = routeName;
    notifyListeners();
    return push(routeName, arguments: arguments);
  }

  bool goBack() {
    return navigatorKey.currentState.pop();
  }

}
