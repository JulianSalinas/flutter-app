import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserView extends StatefulWidget {

  final initialUrl;
  BrowserView({Key key, this.initialUrl}) : super(key: key);

  @override
  _BrowserViewState createState() => _BrowserViewState();
}

class _BrowserViewState extends State<BrowserView> {

  String currentUrl = '...';
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {

    final content = WebView(
      initialUrl: widget.initialUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) => _controller.complete(controller),
      onPageStarted: (url) => setState(() { currentUrl = url; }),
    );

    final body = Container(
      child: content,
    );

    final title = FutureBuilder(
      future: _controller.future,
      builder: (_, snapshot) => BrowserTitle(snapshot.hasData ? snapshot.data : '...'),
    );

    final url = Text(
      currentUrl,
      style: TextStyle(fontSize: 12, ),
      overflow: TextOverflow.ellipsis,
    );

    final titleWrapper = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, url],
    );

    final appBar = AppBar(
      title: titleWrapper,
      centerTitle: true,
      flexibleSpace: ColoredFlex(),
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );

  }
}

class BrowserTitle extends StatelessWidget {

  final WebViewController controller;
  const BrowserTitle(this.controller);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getTitle(),
      builder: (_, snapshot) => FormalText(snapshot.hasData ? snapshot.data : "..."),
    );
  }

}