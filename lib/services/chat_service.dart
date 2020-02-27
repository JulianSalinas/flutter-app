import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/services/users_service.dart';
import 'package:letsattend/services/synched/firebase_service.dart';

class ChatService extends FirebaseService<Message> {

  @override
  String get path => 'edepa6/chat';

  @override
  String get orderBy => 'timestamp';

  final UsersService _usersService = locator<UsersService>();

  @override
  Future<Message> fromFirebase(DataSnapshot snapshot) async {

    final data = { 'key': snapshot.key, ...snapshot.value };
    User sender = await _usersService.getUserById(data['userid']);

    return Message(
      key: data['key'],
      sender: sender,
      content: data['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['time']),
    );

  }
}
