import 'package:flutter/material.dart';
import 'package:letsattend/shared/switch/night_switch.dart';

/// It wraps a component to allow it to take the full space
/// Adds a switch to change between dark and light mode
class Screen extends StatelessWidget {

  final Widget child;
  Screen({@required this.child});

  @override
  Widget build(BuildContext context) {

    /// Makes the widget to take the remain space
    final expanded = Expanded(
      child: child,
    );

    /// Wraps the screen and put and dark mode switch
    return Column(children: [expanded, NightSwitch()]);

  }
}
