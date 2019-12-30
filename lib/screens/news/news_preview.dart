import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/models/preview.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:provider/provider.dart';

class NewsPreview extends StatelessWidget {

  final Preview preview;

  const NewsPreview({
    Key key,
    @required this.preview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);

    if(preview.image != null) {

      final image = Image.network(
        preview.image,
        fit: BoxFit.cover,
      );

      final roundedImage = ClipRRect(
        child: image,
        borderRadius: BorderRadius.circular(4),
      );

      final touchableFilter = Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: InkWell(onTap: () => print('Image clicked!')),
        ),
      );

      return Stack(
        children: [roundedImage, touchableFilter],
      );

    }

    final thumbnail = preview.thumbnail != null ? Image.network(
      preview.thumbnail,
      width: 48,
      height: 48,
      fit: BoxFit.cover,
    ): SizedBox.shrink();

    final title = Text(
      preview.title,
      style: TextStyle(fontWeight: FontWeight.bold),
    );

    final url = preview.url != null ? Text(
      preview.url,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      overflow: TextOverflow.ellipsis,
    ): SizedBox.shrink();

    final description = preview.description != null ? Text(
      preview.description,
    ): SizedBox.shrink();
    
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(height: 2),
        url,
        SizedBox(height: 2),
        description
      ],
    );

    final contentWithThumbnail = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [thumbnail, SizedBox(width: 8), Expanded(child: content)],
    );
    
    final contentWithPadding = Padding(
      padding: EdgeInsets.all(8),
      child: contentWithThumbnail,
    );

    final decoration = Container(
      width: 2,
      color: Colors.red,
    );

    final decoratedContent = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [decoration, Expanded(child: contentWithPadding)],
    );

    final container = Container(
      color: scheme.nightMode ? UIColors.nightOverlay : UIColors.lightOverlay,
      child: IntrinsicHeight(child: decoratedContent),
    );

    return InkWell(
      child: container,
      onTap: () => print('Post clicked'),
    );

  }

}