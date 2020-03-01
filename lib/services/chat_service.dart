import 'package:firebase_database/firebase_database.dart';

import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/services/firebase_service.dart';

class ChatService extends FirebaseService<Message> {

  ChatService() : super('edepa6/chat', orderBy: 'timestamp');

  Future<User> getUser(dynamic data) async {
    return usersService.getUser(data['userid']);
  }

  @override
  Future<Message> castSnapshot(DataSnapshot snapshot) async {

    final data = snapshot.value;
    final user = await auth.user;
    final sender = await getUser(data);

    return Message(
      key: snapshot.key,
      sender: sender,
      content: data['content'],
      isOwned: user.key == sender.key,
      timestamp: castMilliseconds(data['time']),
    );

  }

}
