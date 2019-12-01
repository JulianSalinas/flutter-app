import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/shared/utext.dart';

/// Custom button with icon that adapts itself according
/// to the active scheme
/// It depends on the provider [scheme.dart]
class UButton extends StatelessWidget {

  final String text;
  final Color color;
  final IconData icon;
  final Function onPressed;

  UButton(
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
      UText(text.toUpperCase(), color: Colors.white),
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
      onPressed: this.onPressed,
    );

    return raiseButton;

  }
}
