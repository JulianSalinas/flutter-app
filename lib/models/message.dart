import 'package:letsattend/models/user.dart';

class Message {

  final String key;

  final User sender;
  final String content;
  final DateTime timestamp;

  final bool isOwned;
  final bool delivered;

  Message({
    this.key,
    this.sender,
    this.content,
    this.timestamp,
    this.isOwned = false,
    this.delivered = false,
  });

  toJson() => ({
    'userid': sender.key,
    'username': sender.name,
    'content': content,
    'delivered': delivered,
    'time': DateTime.now().millisecondsSinceEpoch,
  });

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Message && key == other.key;
  }

  @override
  String toString() {
    return 'Message{ key: $key, content: $content, isOwned: $isOwned }';
  }

}
