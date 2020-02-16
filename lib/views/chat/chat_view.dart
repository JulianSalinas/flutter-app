import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/models/message.dart';
import 'package:letsattend/views/chat/empty_bubble.dart';
import 'package:letsattend/views/chat/bubble_widget.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:letsattend/widgets/modern_input.dart';
import 'package:letsattend/widgets/flexible_space.dart';
import 'package:letsattend/view_models/collections/chat_model.dart';


class ChatView extends StatefulWidget {

  static const SCREEN_KEY = 'chat-view';

  ChatView() : super(key: Key(SCREEN_KEY));

  @override
  _ChatViewState createState() => _ChatViewState();

}
class _ChatViewState extends State<ChatView> {

  TextEditingController _editingController = TextEditingController();

  Message createMessage() {
    Map snapshot = Map();
    snapshot['userid'] = 'LUIOPQWSDDGHJW';
    snapshot['username'] = 'Julian Salinas';
    snapshot['content'] = _editingController.text;
    return Message.fromMap(snapshot);
  }

  void sendMessage() {
    if (_editingController.text.trim().isEmpty) return;
    final chatModel = Provider.of<ChatModel>(context);
    chatModel.sendMessage(createMessage().toJson());
    _editingController.text = '';
  }

  @override
  Widget build(BuildContext context) {

    final chatModel = Provider.of<ChatModel>(context);

    final streamBuilder = StreamBuilder(
      stream: chatModel.stream,
      builder: (_, snapshot) => buildView(snapshot),
    );

    final appBar = AppBar(
      title: ModernText('Chat'),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpace(),
    );

    final sendButton = IconButton(
      icon: Icon(Icons.send),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: sendMessage,
    );

    final sendButtonContainer = Container(
      width: 50,
      height: 50,
      child: sendButton,
    );

    final photoButton = IconButton(
      icon: Icon(Icons.camera_alt),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {},
    );

    final messageInput = ModernInput(
      hintText: 'Escriba aquí...',
      multiline: true,
      controller: _editingController,
      leading: photoButton,
    );

    final sendMessageContent = Row(
      children: [
        Flexible(child: messageInput),
        SizedBox(width: 8.0),
        sendButtonContainer,
      ],
    );

    final sendMessageContainer = Container(
      child: sendMessageContent,
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
    );

    final body = Column(
      children: <Widget>[
        Flexible(child: streamBuilder),
        sendMessageContainer,
      ],
    );

    return Scaffold(
      drawer: DrawerView(),
      appBar: appBar,
      body: body,
    );

  }

  Widget buildView(AsyncSnapshot snapshot) {

    if (snapshot.hasData) {
      bool empty = snapshot.data.length > 0;
      return empty ? buildList(snapshot.data) : buildEmpty();
    }

    return snapshot.connectionState == ConnectionState.waiting
        ? buildTemplate()
        : buildError();
  }

  Widget buildList(List<Message> messages) {

    final postWidget = (context, itemIndex) => BubbleWidget(
      message: messages[itemIndex],
      isOwned: itemIndex % 2 == 0,
    );

    final padding = EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    );

    return ListView.separated(
      reverse: true,
      padding: padding,
      itemBuilder: postWidget,
      itemCount: messages.length,
      separatorBuilder: (_, index) => SizedBox(height: 16),
    );

  }

  Widget buildError() {

    final text = Text(
      'ERROR',
      style: TextStyle(fontSize: 24),
    );

    return Center(child: text);

  }

  Widget buildEmpty() {

    final text = Text(
      'VACIO',
      style: TextStyle(fontSize: 24),
    );

    return Center(child: text);

  }

  Widget buildTemplate() {

    final padding = EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    );

    return ListView.separated(
      reverse: true,
      padding: padding,
      itemBuilder: (_, index) => EmptyBubble(index % 2 == 0),
      itemCount: (MediaQuery.of(context).size.height / 120).floor(),
      separatorBuilder: (_, index) => SizedBox(height: 16),
    );

  }

}
