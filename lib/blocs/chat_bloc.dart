import 'package:letsattend/services/chat_service.dart';
import 'package:letsattend/blocs/synched/orderable_bloc.dart';

class ChatBloc extends OrderableBloc<ChatService> {

  @override
  bool get descending => false;

  void sendMessage(dynamic message) async {
    service.addChild(message);
  }

}