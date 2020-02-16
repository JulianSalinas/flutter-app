import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/view_models/theme_model.dart';

class FlexibleSpace extends StatelessWidget {

  const FlexibleSpace({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final settingsModel = Provider.of<SettingsModel>(context);

    final backdrop = ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      ),
    );

    final gradient = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: SharedColors.flareOrange,
        ),
      ),
    );

    return settingsModel.nightMode ? backdrop : gradient;

  }

}
