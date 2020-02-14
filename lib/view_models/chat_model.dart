import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/services/realtime/chat_service.dart';

class ChatModel with ChangeNotifier {

  final ChatService _service = locator<ChatService>();

  Stream<List<Message>> get stream {
    return _service.stream;
  }

  @override
  void dispose() {
    _service.close();
    super.dispose();
  }

}
