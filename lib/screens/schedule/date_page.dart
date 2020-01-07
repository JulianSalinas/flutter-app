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

    events.add(Event(
      id: '-YHDF',
      code: 'T03',
      type: 'FERIA',
      location: 'Laboratorio H',
      start: DateTime.now(),
      end: DateTime.now(),
      title: 'Competencias profesionales de',
      people: [
        Person(name: 'Mayorlan Nunes'),
        Person(name: 'Kimberly Camacho'),
      ],
      isFavorite: true,
    ));

    events.add(Event(
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
    ));

    events.add(Event(
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
    ));

    events.add(Event(
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
    ));

    events.add(Event(
      id: '-SHT665wst6yh4',
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
    ));

    events.add(Event(
      id: '-SDFGH2h456hwsef4154',
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
    ));

    events.add(Event(
      id: '-YHJNDhtsthRSDDF',
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
    ));

    events.add(Event(
      id: '-YHJNDhtsthRwergshtSDDF',
      code: 'T03',
      type: 'FERIA',
      location: 'Laboratorio H',
      start: DateTime.now(),
      end: DateTime.now(),
      title: 'Competencias profesionales de profesores de matemática (prospectiva): aproximaciones cognitivas versus situadas',
      people: [
        Person(name: 'Mayorlan Nunes'),
        Person(name: 'Kimberly Camacho'),
      ],
      isFavorite: true,
    ));

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