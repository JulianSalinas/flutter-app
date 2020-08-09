import 'package:firebase_database/firebase_database.dart';

import 'package:letsattend/locator.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/services/users_service.dart';
import 'package:letsattend/services/firebase_service.dart';

class ChatService extends FirebaseService<Message> {

  final UsersService usersService = locator<UsersService>();

  ChatService() : super('edepa6/chat', orderBy: 'timestamp');

  @override
  Future<Message> parse(DataSnapshot snapshot) async {
    final data = snapshot.value;
    final user = await auth.user;
    final sender = await usersService.getUser(data['userid']);

    return Message(
      key: snapshot.key,
      sender: sender,
      content: data['content'],
      isOwned: user.key == sender.key,
      timestamp: SharedUtils.castMilliseconds(data['time']),
    );
  }

}
