import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:letsattend/router/routes.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/views/chat/empty_bubble.dart';
import 'package:letsattend/views/chat/bubble_widget.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/rounded_input.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:letsattend/blocs/auth/auth_bloc.dart';
import 'package:letsattend/blocs/chat_bloc.dart';


class ChatView extends StatefulWidget {

  ChatView() : super(key: Key('screen${Routes.CHAT_ROUTE}'));

  @override
  _ChatViewState createState() => _ChatViewState();

}
class _ChatViewState extends State<ChatView> {

  TextEditingController _editingController = TextEditingController();

  Message createMessage() {
    final auth = Provider.of<AuthBloc>(context, listen: false);
    assert(auth.user != null);
    return Message.send(
      sender: auth.user,
      content: _editingController.text.trim(),
      timestamp: DateTime.now(),
    );
  }

  void sendMessage() {
    if (_editingController.text.trim().isEmpty) return;
    final chatModel = Provider.of<ChatBloc>(context, listen: false);
    chatModel.sendMessage(createMessage().toJson());
    _editingController.text = '';
  }

  @override
  Widget build(BuildContext context) {

    final chat = Provider.of<ChatBloc>(context);

    final streamBuilder = StreamBuilder(
      stream: chat.stream,
      builder: (_, snapshot) => buildView(snapshot),
    );

    final appBar = AppBar(
      title: FormalText('Chat'),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      flexibleSpace: ColoredFlex(),
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

    final messageInput = RoundedInput(
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
      drawer: DrawerView(Routes.CHAT_ROUTE),
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

    final auth = Provider.of<AuthBloc>(context, listen: false);

    final postWidget = (context, itemIndex) => BubbleWidget(
      message: messages[itemIndex],
      isOwned: auth.user.id == messages[itemIndex].sender.id,
      startSequence: itemIndex == messages.length - 1
          || messages[itemIndex].sender.id != messages[itemIndex + 1].sender.id,
      useTimestamp: itemIndex == messages.length - 1
          || Jiffy(messages[itemIndex].timestamp).startOf('day')
          != Jiffy(messages[itemIndex + 1].timestamp).startOf('day'),
    );

    final padding = EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 16.0,
    );

    return ListView.separated(
      reverse: true,
      padding: padding,
      itemBuilder: postWidget,
      itemCount: messages.length,
      separatorBuilder: (_, index) => SizedBox(height: 12),
    );

  }

  Widget buildError() {

    final text = Text(
      'ERROR INESPERADO',
      style: TextStyle(fontSize: 24),
    );

    return Center(child: text);

  }

  Widget buildEmpty() {

    final text = Text(
      'NO HAY MENSAJES AÚN',
      style: TextStyle(fontSize: 24),
    );

    return Center(child: text);

  }

  Widget buildTemplate() {

    final padding = EdgeInsets.symmetric(
      vertical: 16.0,
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
