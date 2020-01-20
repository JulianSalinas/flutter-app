import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/widgets/event/item_people.dart';
import 'package:letsattend/widgets/hero_text.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

/// A simple colored screen with a centered text
class DetailContent extends StatelessWidget {

  // TODO: Remote after putting the event
  static final String title = lipsum.createParagraph(numSentences: 1);
  static final String abstract = lipsum.createText(numParagraphs: 6);

  final Event event;

  DetailContent({ @required this.event });

  @override
  Widget build(BuildContext context) {

    final itemPeople = ItemPeople(
        people: event.people
    );

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            HeroText(event.title,
              tag: 'event-title-${event.key}',
              style: Typography.englishLike2018.title,
            ),
            SizedBox(
              height: 8,
            ),
            itemPeople,
            Divider(
              thickness: 2,
              height: 32,
            ),
            Text(
              'Abstract',
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              DetailContent.abstract,
              style: Typography.englishLike2018.body2,
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );

  }

}
