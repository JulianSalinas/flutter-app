import 'package:firebase_database/firebase_database.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/services/users_service.dart';
import 'package:letsattend/services/synched/firebase_service.dart';

class ChatService extends FirebaseService<Message> {

  final UsersService _usersService = locator<UsersService>();

  ChatService() : super('edepa6/chat', orderBy: 'timestamp');

  Future<User> getUser(dynamic data) async {
    return _usersService.getUser(data['userid']);
  }

  @override
  Future<Message> castSnapshot(DataSnapshot snapshot) async {

    final data = getData(snapshot);
    final sender = await getUser(data);
    final user = await auth.user;

    return Message(
      key: data['key'],
      sender: sender,
      content: data['content'],
      isOwned: user.id == sender.id,
      timestamp: castMilliseconds(data['time']),
    );

  }

}
