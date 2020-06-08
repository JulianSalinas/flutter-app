import 'package:flutter/material.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:photo_view/photo_view.dart';

class OpenedImage extends StatelessWidget {

  final String imageUrl;

  OpenedImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {

    final content = PhotoView(
      imageProvider: NetworkImage(imageUrl),
      heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
    );

    final container = Container(
      child: content
    );

    final appBar = AppBar(
      title: FormalText('Imagen', color: Colors.white,),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );

    final positionedAppBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: appBar,
    );

    final extendedBody = Stack(
      children: [container, positionedAppBar],
    );

    return Scaffold(
      body: extendedBody,
    );

  }
}
