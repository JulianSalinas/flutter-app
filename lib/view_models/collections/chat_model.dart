import 'package:letsattend/models/message.dart';
import 'package:letsattend/services/realtime/chat_service.dart';
import 'package:letsattend/view_models/collections/orderable_model.dart';
import 'package:letsattend/view_models/collections/stream_model.dart';

class ChatModel extends OrderableModel<ChatService> {

  @override
  bool get descending => false;

  void sendMessage(dynamic message) async {
    service.addChild(message);
  }

}