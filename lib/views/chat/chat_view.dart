import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/models/message.dart';
import 'package:letsattend/views/chat/bubble_widget.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:letsattend/view_models/chat_model.dart';


class ChatView extends StatelessWidget {

  static const SCREEN_KEY = 'chat-view';

  ChatView() : super(key: Key(SCREEN_KEY));

  @override
  Widget build(BuildContext context) {

    final chatModel = Provider.of<ChatModel>(context);

    final body = StreamBuilder(
      stream: chatModel.stream,
      builder: (_, snapshot) => buildView(snapshot),
    );

    final appBar = AppBar(
      title: ModernText('Chat'),
      centerTitle: true,
    );

    return Scaffold(
      drawer: DrawerView(),
      appBar: appBar,
      body: body,
    );
  }

  Widget buildView(AsyncSnapshot<List<Message>> snapshot) {

    if (snapshot.hasData) {
      bool empty = snapshot.data.length > 0;
      return empty ? buildList(snapshot.data) : buildEmpty();
    }

    return snapshot.connectionState == ConnectionState.waiting
        ? buildTemplate()
        : buildError();
  }

  Widget buildList(List<Message> messages) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (_, index) => BubbleWidget(message: messages[index]),
    );
  }

  Widget buildError() {
    return Text('Error');
  }

  Widget buildEmpty() {
    return Text('Empty');
  }

  Widget buildTemplate() {
    return Text('Loading');
  }

}
