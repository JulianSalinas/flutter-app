import 'package:jiffy/jiffy.dart';
import "package:collection/collection.dart";
import 'package:letsattend/models/event.dart';
import 'package:letsattend/services/storage/events_service.dart';
import 'package:letsattend/view_models/collections/filterable_model.dart';

class ScheduleModel extends FilterableModel<EventsService> {

  bool _orderedByType = false;

  get orderedByType => _orderedByType;

  set orderedByType(bool orderedByType) {
    _orderedByType = orderedByType;
    notify(collection);
  }

  @override
  void notify(dynamic collection) {
    Map<String, List<Event>> group = _orderedByType
        ? groupBy(collection, (event) => event.type)
        : groupBy(collection, (event) =>
        Jiffy(event.start.toDate()).format('EEEE d').toUpperCase());
    controller.add(group);
  }

}
