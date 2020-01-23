import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:letsattend/widgets/speaker_widget.dart';
import 'package:letsattend/view_models/speakers_model.dart';

class SpeakerList extends StatefulWidget {
  @override
  SpeakerListState createState() => SpeakerListState();
}

class SpeakerListState extends State<SpeakerList> {

  bool _isSearching = false;
  TextEditingController _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  void startSearch() {
    setState(() => _isSearching = true);
  }

  void closeSearch(SpeakersModel model) {
    model.filter = '';
    _searchQuery.clear();
    setState(() => _isSearching = false);
  }

  void onTap(Speaker speaker) {
    // TODO
  }

  Widget buildSpeakers(_, List<Speaker> speakers){

    final itemCount = speakers.length * 2 - (speakers.length >= 1 ? 1 : 0);

    final speakerWidget = (speaker) => SpeakerWidget(
      key: Key(speaker.key),
      speaker: speaker,
      onTap: () => onTap(speaker),
    );

    final itemBuilder = (_, index) {
      if (index.isOdd) return Divider(height: 0);
      return speakerWidget(speakers[index ~/ 2]);
    };

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      itemCount: itemCount,
      itemBuilder: itemBuilder
    );

  }

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<SpeakersModel>(context);

    final filterIcon = Icon(
      model.descending
          ? MaterialCommunityIcons.sort_ascending
          : MaterialCommunityIcons.sort_descending,
    );

    final filterButton = IconButton(
        icon: filterIcon,
        onPressed: () => model.descending = !model.descending);

    final searchButton = IconButton(
      icon: Icon(Icons.search),
      onPressed: startSearch,
    );

    final closeButton = IconButton(
      icon: Icon(Icons.close),
      onPressed: () => closeSearch(model),
    );

    final searchDecoration = InputDecoration(
      hintText: 'Buscar...',
      border: InputBorder.none,
      hintStyle: TextStyle(color: Colors.white30),
    );

    final searchInput = TextField(
      autofocus: true,
      controller: _searchQuery,
      decoration: searchDecoration,
      onChanged: (query) => model.filter = query,
    );

    final buttons = _isSearching
        ? [closeButton]
        : [filterButton, searchButton];

    final appBar = AppBar(
      actions: buttons,
      title: _isSearching ? searchInput : ModernText('Expositores'),
      centerTitle: true,
    );

    final builder = (_, snapshot) {

      if (snapshot.hasError)
        return new Text('Error: ${snapshot.error}');

      final isWaiting = snapshot.connectionState == ConnectionState.waiting;

      if (isWaiting && !snapshot.hasData)
        return Center(child: CircularProgressIndicator());

      if (snapshot.hasData)
        return buildSpeakers(_, snapshot.data);

      return Text('Nothing to show: ${snapshot.error}');
    };

    return Scaffold(
      appBar: appBar,
      body: StreamBuilder(stream: model.speakers, builder: builder),
    );

  }

}
