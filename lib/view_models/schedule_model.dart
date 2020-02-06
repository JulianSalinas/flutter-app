import 'package:jiffy/jiffy.dart';
import "package:collection/collection.dart";
import 'package:letsattend/models/event.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/view_models/stream_model.dart';

class ScheduleModel extends StreamModel<EventsService> {

  bool _orderedByType = false;

  get orderedByType => _orderedByType;

  set orderedByType(bool orderedByType) {
    _orderedByType = orderedByType;
    notify(collection);
  }

  @override
  void update(dynamic collection) async {
    super.update(collection);
    notify(await collection);
  }

  @override
  void notify(dynamic collection) {
    Map<String, List<Event>> group = _orderedByType
        ? groupBy(collection, (event) => event.type)
        : groupBy(collection, (event) =>
        Jiffy(event.start.toDate()).format('EEEE d').toUpperCase());
    controller.add(group);
  }

  Stream<dynamic> get stream {
    return controller.stream;
  }

}
