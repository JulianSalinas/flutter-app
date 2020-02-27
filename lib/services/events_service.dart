import 'package:letsattend/models/event.dart';
import 'package:letsattend/services/synched/firebase_service.dart';

/// Avoid conflicts with the class Event
import 'package:firebase_database/firebase_database.dart' show DataSnapshot;

class EventsService extends FirebaseService<Event> {

  @override
  String get path => 'edepa6/schedule';

  @override
  String get orderBy => 'start';

  @override
  Future<Event> fromFirebase(DataSnapshot snapshot) async {
    snapshot.value['key'] = snapshot.key;
    return Event.fromMap(snapshot.value);
  }

}
