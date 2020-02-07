import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:letsattend/models/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/services/stream_service.dart';

class ChatService extends StreamService<Message> {
  
  List<Message> _messages = [];
  DatabaseReference _database = FirebaseDatabase.instance.reference();
  StreamController<List<Message>> _controller = StreamController();
  
  ChatService(){

    final reference = _database.child('edepa6/chat');
    
    reference.onChildAdded.map(fromEvent).listen((message) {
      _messages.add(message);
      _controller.add(_messages);
    });

    reference.onChildChanged.map(fromEvent).listen((message) {
      int index = _messages.indexOf(message);
      _messages.removeAt(index);
      _messages.insert(index, message);
      _controller.add(_messages);
    });

    reference.onChildRemoved.map(fromEvent).listen((message) {
      _messages.remove(message);
      _controller.add(_messages);
    });
    
  }

  Message fromEvent(Event event){
    return fromSnapshot(event.snapshot);
  }

  Message fromSnapshot(DataSnapshot snapshot) {
    final key = snapshot.key;
    return Message.fromMap(key, snapshot.value);
  }
  
  Stream<List<Message>> get stream {
    return _controller.stream;
  }

}
