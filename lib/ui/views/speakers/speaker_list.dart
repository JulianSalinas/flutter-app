import 'dart:async';

import 'package:flutter/material.dart';
import 'package:letsattend/core/models/speaker.dart';
import 'package:letsattend/core/services/database/database_service.dart';
import 'package:letsattend/ui/widgets/speaker_widget.dart';
import 'package:letsattend/ui/widgets/modern_text.dart';
import 'package:provider/provider.dart';



class People extends StatefulWidget {

  @override
  PeopleState createState() => PeopleState();

}

/// A simple colored screen with a centered text
class PeopleState extends State<People> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final databaseService = Provider.of<DatabaseService>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: databaseService.speakers,
        builder: (context, AsyncSnapshot<List<Speaker>> snapshot) {

          if(!snapshot.hasData){
            return Text('Cargando');
          }
          else {

//            List<Speaker> speakers = snapshot.data.where((speaker){
//              return (speaker.university ?? speaker.country).startsWith('Instituto');
//            }).toList();

            List<Speaker> speakers = snapshot.data;

            return ListView.builder(
              padding:  EdgeInsets.fromLTRB(0, 8, 0, 8),
              itemBuilder: (_, int i) {

                if (i.isOdd) return Divider(height: 0);

                final index = i ~/ 2;

                final speaker = speakers[index];

//              if ((speaker.university ?? speaker.country).contains('Instituto'))
                return SpeakerWidget(person: speaker);
//              else
//                return Text('Nada');

              },
              itemCount: speakers.length * 2 - 1, // 1 reserved for dividers
            );
          }

        }
      ),
      appBar: AppBar(
        title: ModernText('Expositores'),
        centerTitle: true,
      ),
    );

  }
}
