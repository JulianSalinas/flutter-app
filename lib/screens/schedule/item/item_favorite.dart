import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/colors/flat_ui.dart';

class Favorite extends StatelessWidget {

  final bool isFavorite;
  final Function onPressed;

  Favorite({
    this.isFavorite = false,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    final icon = Icon(
      isFavorite ? AntDesign.star : AntDesign.staro,
      size: 20,
      color: FlatUI.sunflower,
    );

    return IconButton(
      icon: icon,
      onPressed: onPressed,
    );

  }

}

