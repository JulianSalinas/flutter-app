import 'package:letsattend/locator.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/blocs/filterable_bloc.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/services/speakers_service.dart';

class SpeakersBloc extends FilterableBloc<SpeakersService> {

  final EventsService _eventsService = locator<EventsService>();

  Future<List<Event>> getEvents(List<dynamic> keys) {
    return Future.wait(keys.map((key) => _eventsService.getEvent(key)));
  }

}