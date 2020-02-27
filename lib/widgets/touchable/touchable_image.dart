import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/widgets/fullscreen/full_image.dart';


class TouchableImage extends StatelessWidget {

  final String imageUrl;

  const TouchableImage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  openImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FullImage(imageUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {

    final originalImage = Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );

    final roundedImage = ClipRRect(
      child: originalImage,
      borderRadius: BorderRadius.circular(4),
    );

    final heroImage = Hero(
      tag: imageUrl,
      child: roundedImage,
    );

    final imageFilter = Material(
      color: Colors.transparent,
      child: InkWell(onTap: () => openImage(context)),
    );

    final imageOverlay = Positioned.fill(
      child: imageFilter,
    );

    return Stack(children: [heroImage, imageOverlay]);

  }

}