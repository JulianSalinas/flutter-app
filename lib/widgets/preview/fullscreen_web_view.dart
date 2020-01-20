import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/controllers/theme_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';


class FullscreenWebView extends StatelessWidget {

  final String url;
  final String title;

  const FullscreenWebView({
    Key key,
    @required this.url,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<ThemeController>(context);

    final webview = WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );

    final webTitle = Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    final webUrl = Text(
      url,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      overflow: TextOverflow.ellipsis,
    );

    final appBarTitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        webTitle,
        SizedBox(height: 2),
        webUrl,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: false,
      ),
      body: webview,
    );

  }

}