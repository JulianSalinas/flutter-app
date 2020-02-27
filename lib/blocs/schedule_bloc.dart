import 'package:jiffy/jiffy.dart';
import "package:collection/collection.dart";
import 'package:letsattend/models/event.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/blocs/synched/filterable_bloc.dart';

class ScheduleBloc extends FilterableBloc<EventsService> {

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
        Jiffy(event.start).format('EEEE d').toUpperCase());
    controller.add(group);
  }

}
