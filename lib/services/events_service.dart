import 'dart:async';

import 'package:letsattend/locator.dart';
import 'package:letsattend/models/user.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/speaker.dart';

import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/services/firebase_service.dart';
import 'package:letsattend/services/speakers_service.dart';
import 'package:letsattend/services/favorites_service.dart';
import 'package:firebase_database/firebase_database.dart' show DataSnapshot;

class EventsService extends FirebaseService<Event> {

  final SpeakersService _speakersService = locator<SpeakersService>();
  final FavoritesService _favoritesService = locator<FavoritesService>();

  late StreamSubscription _favoriteAddedSubscription;
  late StreamSubscription _favoriteRemovedSubscription;

  EventsService() : super('edepa6/schedule', orderBy: 'start'){
    subscribeFavoritesChanges(auth.user);
  }

  void subscribeFavoritesChanges(AppUser user) {

    final reference = database
        .child('edepa6')
        .child('favorites')
        .child(user.key);

    _favoriteAddedSubscription = reference
        .onChildAdded
        .listen((data) => onFavoriteChanged(data, true));

    _favoriteRemovedSubscription = reference
      .onChildRemoved
      .listen((data) => onFavoriteChanged(data, false));
  }

  void onFavoriteChanged(dynamic data, bool isFavorite) {
    final find = (event) => event.key == data.snapshot.key;
    Event event = collection.firstWhere(find);
    event.isFavorite = isFavorite;
    _onCollectionChanged(event);
  }

  void _onCollectionChanged(Event event)  {
    int index = collection.indexOf(event);
    collection.removeAt(index);
    collection.insert(index, event);
    controller.add(collection);
  }

  Future<Event?> getEvent(dynamic key) async {

    final snapshot = await database
        .child('edepa6')
        .child('schedule')
        .child(key)
        .once();

    return parse(snapshot);
  }

  Future<Speaker?> getSpeaker(dynamic key) async {
    return await _speakersService.getSpeaker(key);
  }

  @override
  Future<Event?> parse(DataSnapshot snapshot) async {

    if (snapshot.key == null || snapshot.value == null) return null;

    final data = snapshot.value;
    Map people = data['people'] ?? {};

    final isFavorite = await _favoritesService.isFavorite(snapshot.key!);

    final event = Event(
      key: snapshot.key!,
      code: data['id'],
      type: data['eventype'],
      title: SharedUtils.cleanText(data['title']) ?? "unknown",
      description: SharedUtils.cleanText(data['briefSpanish']),
      start: SharedUtils.castMilliseconds(data['start']),
      end: SharedUtils.castMilliseconds(data['end']),
      image: 'assets/tec_edificio_a4.jpg',
      location: SharedUtils.cleanText(data['location']),
      isFavorite: isFavorite,
    );

    final speakers = await Future.wait(people.keys.map(getSpeaker));
    event.speakers = speakers.where((sp) => sp != null).cast<Speaker>().toList();
    return event;

  }

  @override
  void close() {
    _favoriteAddedSubscription.cancel();
    _favoriteRemovedSubscription.cancel();
    super.close();
  }

}
