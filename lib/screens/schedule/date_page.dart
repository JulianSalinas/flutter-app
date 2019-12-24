import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/person.dart';
import 'package:letsattend/shared/event/item.dart';

class DatePage extends StatefulWidget {

  final DateTime date;
  DatePage({@required this.date});

  @override
  DatePageState createState() => DatePageState();
}

class DatePageState extends State<DatePage> {

  List<Event> events = <Event>[];

  @override
  void initState() {
    super.initState();

    final Event e1 = Event(
      id: '-SHT6654',
      code: 'P01',
      type: 'PONENCIA',
      location: 'Centro de las Artes',
      start: DateTime.now(),
      end: DateTime.now(),
      title: 'Competencias profesionales de profesores de matemática',
      people: [
        Person(name: 'Julian Salinas'),
        Person(name: 'Aquiles Van Stengel'),
        Person(name: 'Luna Pancrasia'),
      ],
      isFavorite: true,
    );

    final Event e2 = Event(
      id: '-SDFGH24154',
      code: 'C02',
      type: 'CONFERENCIA',
      location: 'Auditorio B1',
      start: DateTime.now(),
      end: DateTime.now(),
      title: 'Competencias profesionales de profesores de matemática (prospectiva): aproximaciones cognitivas versus si',
      people: [
        Person(name: 'Josseline Alfaro'),
      ],
      isFavorite: false,
    );

    final Event e3 = Event(
      id: '-YHJNDRSDDF',
      code: 'T03',
      type: 'TALLER',
      location: 'Laboratorio H',
      start: DateTime.now(),
      end: DateTime.now(),
      title: 'Competencias profesionales de profesores de matemática (prospectiva): aproximaciones cognitivas versus situadas',
      people: [
        Person(name: 'Mayorlan Nunes'),
        Person(name: 'Kimberly Camacho'),
      ],
      isFavorite: true,
    );

    events.addAll([e1, e2, e3]);
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => Item(
        event: events.elementAt(index),
        isFirst: index == 0,
        isLast: index == events.length - 1,
        isOdd: index.isEven,
        onFavoriteChanged: onFavoriteChange,
      ),
    );

  }


  onFavoriteChange(Event event) {
    setState(() {
      event.isFavorite = !event.isFavorite;
    });
  }

}