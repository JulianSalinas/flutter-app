abstract class SynchedService<T> {

  Stream<List<T>> get stream;
  void close();

}