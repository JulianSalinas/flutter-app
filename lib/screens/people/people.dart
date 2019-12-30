import 'package:flutter/material.dart';
import 'package:letsattend/models/person.dart';
import 'package:letsattend/screens/people/people_item.dart';
import 'package:letsattend/shared/text/modern_text.dart';


class People extends StatefulWidget {

  @override
  PeopleState createState() => PeopleState();

}

/// A simple colored screen with a centered text
class PeopleState extends State<People> {

  List<Person> people = <Person>[];

  @override
  void initState() {
    super.initState();
    people.add(Person(
      name: 'Julian Salinas',
      country: 'Costa Rica',
      about: 'Tecnologico de Costa Rica'
    ));
    people.add(Person(
      name: 'Aquiles Van Stengel',
      country: 'Australia',
      about: 'Perro de Julian'
    ));
    people.add(Person(
        name: 'Luna Pancrasia',
        country: 'Un lugar del más allá',
        about: 'Gata de Mary'
    ));
  }

  Widget buildItem(BuildContext context, int i){

    if (i.isOdd) return Divider(height: 0);

    final index = i ~/ 2;

    return PeopleItem(person: people[index]);
  }

  @override
  Widget build(BuildContext context) {

    final listView = ListView.builder(
      padding:  EdgeInsets.fromLTRB(0, 8, 0, 8),
      itemBuilder: buildItem,
      itemCount: people.length * 2 - 1, // 1 reserved for dividers
    );

    return Scaffold(
      body: listView,
      appBar: AppBar(
        title: ModernText('Expositores'),
        centerTitle: true,
      ),
    );

  }
}
