import 'package:letsattend/models/filter.dart';

abstract class DatabaseService<T> {

  Stream<List<T>> getSpeakersStream(Filter filter);

}