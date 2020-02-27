
import 'package:flutter/material.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:photo_view/photo_view.dart';

class FullImage extends StatelessWidget {

  final String imageUrl;

  FullImage(this.imageUrl);

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
      children: <Widget>[container, positionedAppBar],
    );

    return Scaffold(
      body: extendedBody,
    );

//    return CachedNetworkImage(
//      imageUrl: imageUrl,
//      imageBuilder: (context, imageProvider) => Container(
//        child: Container(
//          child: PhotoView(
//            imageProvider: imageProvider,
//          )
//        ),
//      ),
//      placeholder: (context, url) => CircularProgressIndicator(),
//      errorWidget: (context, url, error) => Icon(Icons.error),
//    );
  }
}
