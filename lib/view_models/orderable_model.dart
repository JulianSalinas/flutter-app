import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/services/stream_service.dart';
import 'package:letsattend/view_models/filterable_model.dart';

class OrderableModel<T extends StreamService> extends FilterableModel<T> {

  bool _descending = true;

  get descending => _descending;

  set descending(bool descending) {
    _descending = descending;
    notify(collection);
    notifyListeners();
  }

  @override
  void notify(dynamic collection) {
    controller.add(descending
        ? collection.toList()
        : collection.reversed.toList(),
    );
  }

}
