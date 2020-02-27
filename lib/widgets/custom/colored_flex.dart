import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:provider/provider.dart';

class ColoredFlex extends StatelessWidget {

  const ColoredFlex({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsBloc>(context);

    final backdropFilter = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
    );

    final clipRect = ClipRect(
      child: backdropFilter,
    );

    final linearGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: SharedColors.flareOrange,
    );

    final decoration = BoxDecoration(
      gradient: linearGradient,
    );

    final decoratedContainer = Container(
      decoration: decoration,
    );

    return settings.nightMode ? clipRect : decoratedContainer;
  }
}
