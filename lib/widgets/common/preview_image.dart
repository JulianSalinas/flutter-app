import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Github/letsattend/lib/widgets/common/opened_image.dart';

class PreviewImage extends StatelessWidget {

  final String imageUrl;

  PreviewImage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  openImage(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => OpenedImage(imageUrl));
    Navigator.push(context, route);
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
