import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/person.dart';
import 'package:letsattend/screen.dart';
import 'package:letsattend/screens/schedule/item/item.dart';

class Sheet extends StatefulWidget {

  final DateTime date;
  Sheet({@required this.date});

  @override
  SheetState createState() => SheetState();
}

class SheetState extends State<Sheet> {

  List<Event> events = <Event>[];

  @override
  void initState() {
    super.initState();

    final Event e1 = Event(
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
      code: 'C02',
      type: 'CONFERENCIA',
      location: 'Auditorio B1',
      start: DateTime.now(),
      end: DateTime.now(),
      title: 'Competencias profesionales',
      people: [
        Person(name: 'Josseline Alfaro'),
      ],
      isFavorite: false,
    );

    final Event e3 = Event(
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

    final listView = ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => Item(
        event: events.elementAt(index),
        isFirst: index == 0,
        isLast: index == events.length - 1,
        isOdd: index.isEven,
        onFavoriteChanged: onFavoriteChange,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Screen(
          child: listView,
        ),
      ),
    );
  }


  onFavoriteChange(Event event) {
    setState(() {
      event.isFavorite = !event.isFavorite;
    });
  }

}