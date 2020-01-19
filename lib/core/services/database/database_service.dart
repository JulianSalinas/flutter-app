import 'package:flutter/cupertino.dart';
import 'package:letsattend/core/models/speaker.dart';

abstract class DatabaseService with ChangeNotifier{

  Stream<List<Speaker>> get speakers;

}