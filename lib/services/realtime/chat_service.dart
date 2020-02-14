import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/message.dart';
import 'package:letsattend/services/realtime/firebase_service.dart';

class ChatService extends FirebaseService<Message> {

  @override
  String get path => 'edepa6/chat';

  @override
  Message fromFirebase(Event data) {
    DataSnapshot snapshot = data.snapshot;
    snapshot.value['key'] = snapshot.key;
    return Message.fromMap(snapshot.value);
  }

}
