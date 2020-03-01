import 'package:letsattend/blocs/orderable_bloc.dart';
import 'package:letsattend/services/chat_service.dart';

class ChatBloc extends OrderableBloc<ChatService> {

  @override
  get descending => false;

  Future<void> sendMessage(dynamic message) async {
    await service.addChild(message);
  }

}