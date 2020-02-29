import 'package:letsattend/locator.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/services/news_service.dart';
import 'package:letsattend/blocs/auth/auth_bloc.dart';
import 'package:letsattend/blocs/news_bloc.dart';
import 'package:letsattend/views/news/news_view.dart';
import 'package:letsattend/views/news/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/router/router.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/blocs/settings_bloc.dart';


/// A simple colored screen with a centered text
class HomeOption extends StatelessWidget {

  final Icon icon;
  final Color color;
  final Function onTap;


  HomeOption({
    @required this.icon,
    @required this.onTap,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.all(Radius.circular(8.0));

    final content = Container(
      padding: EdgeInsets.all(20),
      child: icon,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
    );

    final inkWell = InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: content,
    );

    return Material(
      color: color,
      elevation: 16.0,
      borderRadius: borderRadius,
      borderOnForeground: true,
      child: inkWell,
    );

  }


}
