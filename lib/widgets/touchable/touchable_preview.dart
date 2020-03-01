import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/models/preview.dart';
import 'package:letsattend/widgets/fullscreen/full_web_view.dart';
import 'package:provider/provider.dart';

import 'touchable_image.dart';

class TouchablePreview extends StatelessWidget {

  final Preview preview;

  const TouchablePreview({
    Key key,
    @required this.preview,
  }) : super(key: key);

  openUrl(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FullWebView(
        title: preview.title,
        url: preview.url,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<SettingsBloc>(context);

//    if(preview.image != null)
//      return TouchableImage(imageUrl: preview.image);

    final thumbnail = preview.thumbnail != null ? Image.network(
      preview.thumbnail,
      width: 36,
      height: 36,
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
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
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
      color: scheme.nightMode ? Color(0x0FFFFFFF) : Color(0x0F000000),
      child: IntrinsicHeight(child: decoratedContent),
    );

    return InkWell(
      child: container,
      onTap: () => openUrl(context),
      onLongPress: () {
        Clipboard.setData(ClipboardData(
          text: preview.url
        )).then((result) {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('Copiado al portapapeles'),
            duration: Duration(seconds: 1),
          ));
        });
      },
    );

  }

}