import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:provider/provider.dart';

/// Switch used to change the theme scheme
/// It depends on the provider [theme_model.dart]
class NightSwitch extends StatelessWidget {

  final String text;
  final Color color;

  NightSwitch({
    this.color,
    this.text = 'MODO OSCURO',
  });

  Widget build(BuildContext context) {

    /// Gets the properties for the switch
    final themeModel = Provider.of<ThemeModel>(context);

    /// Cupertino switch also works on Android
    final switchComponent = Switch(
      value: themeModel.nightMode,
      onChanged: (bool active) => themeModel.nightMode = active,
      activeColor: SharedColors.pomegranate,
    );

    final description = [
      Icon(MaterialCommunityIcons.weather_night),
      SizedBox(width: 16),
      ModernText(text),
    ];

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Row(children: description), switchComponent],
    );

    final container = Container(
      height: 48,
      child: content,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      color: Colors.transparent,
    );

    /// It's wrapped 'cause it creates the effect of being static
    /// when switching between screens
    return Hero(
      tag: 'theme-switch-mkg',
      child: container,
    );

  }
}
