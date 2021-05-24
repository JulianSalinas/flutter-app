import 'package:letsattend/locator.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/blocs/filterable_bloc.dart';
import 'package:letsattend/services/events_service.dart';
import 'package:letsattend/services/favorites_service.dart';
import 'package:letsattend/services/speakers_service.dart';

class SpeakersBloc extends FilterableBloc<SpeakersService> {

  final EventsService _eventsService = locator<EventsService>();
  final FavoritesService _favoritesService = locator<FavoritesService>();

  Future<List<Event>> getEvents(List<dynamic> keys) async {
    var list = await Future.wait(keys.map((key) => _eventsService.getEvent(key)));
    return list.where((element) => element != null) as List<Event>;
  }

  Future<void> toggleFavorite(Event event) async {
    return _favoritesService.setFavorite(event.key, !event.isFavorite);
  }

}