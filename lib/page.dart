import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/view_models/collections/stream_model.dart';

class RealtimePage<T extends StreamModel> extends MaterialPageRoute {

  final Widget child;

  RealtimePage(this.child) : super(
    builder: (context) => ChangeNotifierProvider<T>(
      create: (context) => locator<T>(),
      child: child,
    ),
  );

}
