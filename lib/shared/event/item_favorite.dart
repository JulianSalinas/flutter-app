import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/colors/flat_ui.dart';

class Favorite extends StatefulWidget {

  final String tag;
  final bool isFavorite;
  final Function onPressed;

  Favorite({
    @required this.tag,
    this.isFavorite = false,
    this.onPressed
  });

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> with SingleTickerProviderStateMixin{

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {

    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0.1
    );

    animation = Tween(
        begin: 0.0,
        end: pi * 1.2,
    ).animate(animationController);

  }

  onPressed(){
    widget.onPressed();
    animationController.isCompleted ?
    animationController.reverse() :
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final icon = Icon(
      widget.isFavorite ? AntDesign.star : AntDesign.staro,
      size: 20,
      color: FlatUI.sunflower,
    );

    final button = IconButton(
      icon: icon,
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );

    final animatedButton =  AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.rotate(
        angle: animation.value,
        child: button,
      ),
    );

    return Hero(
      tag: widget.tag,
      child: animatedButton,
    );

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

}

