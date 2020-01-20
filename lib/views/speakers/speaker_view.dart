import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:letsattend/widgets/speaker_widget.dart';
import 'package:letsattend/controllers/speakers_controller.dart';

class SpeakerList extends StatefulWidget {
  @override
  SpeakerListState createState() => SpeakerListState();
}

/// A simple colored screen with a centered text
class SpeakerListState extends State<SpeakerList> {

  bool _isSearching = false;
  TextEditingController _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    print('Search opened');
    setState(() => _isSearching = true);
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() => _isSearching = false);
  }

  void _clearSearchQuery() {
    print('Search closed');
    setState(() => _searchQuery.clear());
  }

  @override
  Widget build(BuildContext context) {

    final speakersCtrl = Provider.of<SpeakersController>(context);

    final filterIcon = Icon(speakersCtrl.asc
        ? MaterialCommunityIcons.sort_descending
        : MaterialCommunityIcons.sort_ascending,
    );

    final filterButton = IconButton(
      icon: filterIcon,
      onPressed: () => speakersCtrl.asc = !speakersCtrl.asc
    );

    final searchButton = IconButton(
      icon: Icon(Icons.search),
      onPressed: _startSearch,
    );

    final closeButton = IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        _clearSearchQuery();
        speakersCtrl.filter = '';
        setState(() => _isSearching = false);
      },
    );

    final searchInput = TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Buscar...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (String newQuery) {
        print('Searching: $newQuery');
        speakersCtrl.filter = newQuery;
      },
    );

    return Scaffold(
      body: StreamBuilder(
        stream: speakersCtrl.speakers,
        builder: (_, snapshot) {

          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');

          if(snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData){
            return new Text('Loading...');
          }

          if(snapshot.hasData){

            List<Speaker> speakers = snapshot.data;

            return ListView.builder(
              padding:  EdgeInsets.fromLTRB(0, 8, 0, 8),
              itemBuilder: (_, int i) {
                if (i.isOdd) return Divider(height: 0);
                final index = i ~/ 2;
                final speaker = speakers[index];
                return SpeakerWidget(
                  key: Key(speaker.key),
                  speaker: speaker,
                  onTap: () { },
                );
              },
              itemCount: (speakers.length * 2) - (speakers.length >= 1 ? 1 : 0),
            );
          }


          return new Text('Nothing to show: ${snapshot.error}');

        },
      ),
      appBar: AppBar(
        title: _isSearching ? searchInput : ModernText('Expositores'),
        centerTitle: true,
        actions: <Widget>[
          if(!_isSearching) ...[
            filterButton,
            searchButton,
          ]
          else ... [
            closeButton
          ]
        ],
      ),
    );

  }
}
