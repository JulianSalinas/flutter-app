import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';

/// Custom button with icon that adapts itself according
/// to the active scheme
class RoundedButton extends StatelessWidget {

  final String text;
  final Color color;
  final Color? textColor;
  final IconData? icon;
  final VoidCallback? onPressed;

  RoundedButton(
    this.text, {
    this.icon,
    this.color = SharedColors.emerald,
    this.textColor,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final buttonIcon = icon == null ? SizedBox.shrink() : Icon(
      icon,
      color: textColor ?? Colors.white,
    );

    final content = [
      buttonIcon,
      SizedBox(width: icon == null ? 0 : 8),
      FormalText(text.toUpperCase(), color: textColor ?? Colors.white,),
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

    // final border = RoundedRectangleBorder(
    //   borderRadius: new BorderRadius.circular(24),
    //   side: BorderSide(color: color, width: 0),
    // );

    final raiseButton = ElevatedButton(
      child: container,
      onPressed: onPressed,
    );

    return raiseButton;

  }
}
