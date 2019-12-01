import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class TileView extends StatelessWidget {

  final WordPair word;

  const TileView({
    Key key,
    @required this.word,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Text(word.toString(), style: TextStyle(fontSize: 18.0),);
    return ListTile(title: text);
  }

}

class ListExample extends StatefulWidget {
  @override
  ListExampleState createState() => ListExampleState();
}

class ListExampleState extends State<ListExample> {

  final words = <WordPair>[];

  Widget buildItem(BuildContext context, int i){

    if (i.isOdd) return Divider();

    final index = i ~/ 2;
    if (index >= words.length)
      words.addAll(generateWordPairs().take(10));

    return TileView(word: words[index]);
  }

  @override
  Widget build(BuildContext context) {

    final listView = ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: buildItem
    );

    return Scaffold(body: SafeArea(child: listView));
  }

}