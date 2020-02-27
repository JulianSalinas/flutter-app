import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/blocs/synched/synched_bloc.dart';

class SynchedPage<T extends SynchedBloc> extends MaterialPageRoute {
  final Widget child;

  static Widget _getProvider<T extends SynchedBloc>(child) {
    final model = (_) => locator<T>();
    return ChangeNotifierProvider<T>(create: model, child: child);
  }

  SynchedPage(this.child) : super(builder: (_) => _getProvider<T>(child));
}
