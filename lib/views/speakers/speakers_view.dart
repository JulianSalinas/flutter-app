import 'package:letsattend/router/routes.dart';
import 'package:letsattend/views/settings/section_title.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:letsattend/views/speakers/speaker_widget.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/views/speakers/loading_speakers.dart';
import 'package:letsattend/blocs/speakers_bloc.dart';

class SpeakersView extends StatefulWidget {
  @override
  SpeakersViewState createState() => SpeakersViewState();
}

class SpeakersViewState extends State<SpeakersView> {

  bool _isSearching = false;
  late TextEditingController _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  void startSearch() {
    setState(() => _isSearching = true);
  }

  void closeSearch(SpeakersBloc model) {
    model.filter = '';
    _searchQuery.clear();
    setState(() => _isSearching = false);
  }

  /// Also counts headers
  int countItems(List<Speaker> speakers) {
    return speakers.length * 2 - (speakers.length >= 1 ? 1 : 0);
  }

  /// Builds the speaker with a header if necessary
  Widget buildSpeaker(List<Speaker> speakers, int itemIndex) {

    if (itemIndex.isOdd)
      return Divider(height: 0);

    int i = itemIndex ~/ 2;
    Speaker speaker = speakers[i];

    final speakerWidget = SpeakerWidget(
      key: Key(speaker.key),
      speaker: speaker,
    );

    if (i != 0 && (speaker.initial == speakers[i - 1].initial))
      return speakerWidget;

    final headerText = SectionTitle(speaker.initial);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [headerText, speakerWidget],
    );

  }

  /// Builds the list where speakers are contained
  Widget buildSpeakers(List<Speaker> speakers) {

    return ListView.builder(
      itemCount: countItems(speakers),
      itemBuilder: (_, itemIndex) => buildSpeaker(speakers, itemIndex),
    );
  }

  /// Shows the data or the loading screen accordingly
  Widget streamBuilder(snapshot) {
    if (snapshot.hasError)
      return Text('Error: ${snapshot.error}');

    final isWaiting = snapshot.connectionState == ConnectionState.waiting;

    if (isWaiting && !snapshot.hasData)
      return LoadingSpeakers();

    return buildSpeakers(snapshot.data);
  }

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<SpeakersBloc>(context);

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
      style: TextStyle(color: Colors.white),
      onChanged: (query) => model.filter = query,
    );

    final buttons = _isSearching
        ? [closeButton]
        : [filterButton, searchButton];

    final appBar = AppBar(
        actions: buttons,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: _isSearching ? searchInput : FormalText('Expositores'),
        flexibleSpace: ColoredFlex(),
    );

    final body = StreamBuilder(
      stream: model.stream,
      builder: (_, snapshot) => streamBuilder(snapshot),
    );

    return Scaffold(
      drawer: DrawerView(Routes.speakersRoute),
      body: body,
      appBar: appBar
    );

  }

}