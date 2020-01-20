import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors.dart';
import 'package:letsattend/widgets/modern_text.dart';

/// Custom button with icon that adapts itself according
/// to the active scheme
/// It depends on the provider [theme_controller.dart]
class ModernButton extends StatelessWidget {

  final String text;
  final Color color;
  final IconData icon;
  final Function onPressed;

  ModernButton(
    this.text, {
    this.icon,
    this.color = FlatUI.emerald,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final buttonIcon = icon == null ? SizedBox.shrink() : Icon(
      icon,
      color: Colors.white,
    );

    final content = [
      buttonIcon,
      SizedBox(width: icon == null ? 0 : 8),
      ModernText(text.toUpperCase(), color: Colors.white),
    ];

    final wrapper = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );

    final container = Container(
      height: 48,
      padding: EdgeInsets.all(4),
      child: wrapper,
    );

    final border = RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(24),
      side: BorderSide(color: color, width: 0),
    );

    final raiseButton = RaisedButton(
      color: color,
      shape: border,
      child: container,
      onPressed: onPressed,
    );

    return raiseButton;

  }
}
