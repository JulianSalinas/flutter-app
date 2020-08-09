import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:provider/provider.dart';

class PersonHeader extends StatefulWidget {

  final Speaker speaker;

  PersonHeader({ @required this.speaker });

  @override
  _PersonHeaderState createState() => _PersonHeaderState();
}

class _PersonHeaderState extends State<PersonHeader> {

  static const int EVENTS_TAB = 0;
  static const int ABOUT_TAB = 1;
  int segmentedControlGroupValue = 0;

  onSegmentedControlValueChanged(int index) {
    setState(() { segmentedControlGroupValue = index; });
  }

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsBloc>(context);

    final initials = Text(
      widget.speaker.initials,
      style: TextStyle(fontSize: 28, color: Colors.white),
    );

    final avatar = CircleAvatar(
      radius: 40,
      backgroundColor: widget.speaker.color,
      child: initials,
    );

    final borderedAvatar = CircleAvatar(
      radius: 44,
      backgroundColor: Colors.white24,
      child: avatar,
    );

    final heroAvatar = Hero(
      child: borderedAvatar,
      tag: 'avatar${widget.speaker.key}',
    );

    final speakerName = Text(
      widget.speaker.name,
      style: Typography.englishLike2018.headline6.copyWith(
        color: Colors.white
      ),
    );

    final heroName = Hero(
      tag: 'name${widget.speaker.key}',
        child: Material(child: speakerName, color: Colors.transparent),
    );

    final availableTabs = <int, Widget> {
      EVENTS_TAB: Text('Eventos'),
      ABOUT_TAB: Text('Acerca de'),
    };

    final segmentedControl = CupertinoSlidingSegmentedControl(
      groupValue: segmentedControlGroupValue,
      children: availableTabs,
      onValueChanged: onSegmentedControlValueChanged,
      backgroundColor: settings.nightMode ? Colors.black26 : Colors.white24,
    );

    final subtitle = widget.speaker.university != null
        ? '${widget.speaker.university}, ${widget.speaker.country}'
        : widget.speaker.country;

    final subtitleText = Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white),
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        heroAvatar,
        SizedBox(height: 16),
        heroName,
        SizedBox(height: 8),
        subtitleText,
        SizedBox(height: 16),
        segmentedControl,
      ],
    );

    final container = Container(
      child: content,
      padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
    );

    return Stack(
      fit: StackFit.expand,
      children: [ColoredFlex(), container],
    );

  }
}
