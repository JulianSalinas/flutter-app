import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:letsattend/widgets/speaker_widget.dart';
import 'package:letsattend/view_models/speakers_model.dart';
import 'package:letsattend/views/speakers/empty_speakers_view.dart';

class SpeakersView extends StatefulWidget {
  @override
  SpeakersViewState createState() => SpeakersViewState();
}

class SpeakersViewState extends State<SpeakersView> {
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
    print(speaker.toString());
  }

  Widget buildSpeakers(_, List<Speaker> speakers) {

    final itemCount = speakers.length * 2 - (speakers.length >= 1 ? 1 : 0);

    final itemBuilder = (_, itemIndex) {

      if (itemIndex.isOdd)
        return Divider(height: 0);

      int i = itemIndex ~/ 2;
      Speaker speaker = speakers[i];

      final safeInitial = (Speaker speaker) =>
          speaker.name.length >= 1 ? speaker.name[0].toUpperCase() : '#';

      final speakerWidget = SpeakerWidget(
        key: Key(speaker.key),
        speaker: speaker,
        onTap: () => onTap(speaker),
      );

      final headerText = Text(
        safeInitial(speaker),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );

      final tintedHeader = Container(
        color: Colors.grey.withOpacity(0.05),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Row(children: <Widget>[headerText]),
      );

      final speakerWithHeader = (Speaker speaker) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [tintedHeader, speakerWidget],
      );

      if (i == 0 || (safeInitial(speaker) != safeInitial(speakers[i - 1])))
        return speakerWithHeader(speaker);

      return speakerWidget;

    };

    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
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

    final buttons = _isSearching ? [closeButton] : [filterButton, searchButton];

    final appBar = AppBar(
      actions: buttons,
      title: _isSearching ? searchInput : ModernText('Expositores'),
      centerTitle: true,
    );

    final builder = (_, snapshot) {
      if (snapshot.hasError) return Text('Error: ${snapshot.error}');

      final isWaiting = snapshot.connectionState == ConnectionState.waiting;

      if (isWaiting && !snapshot.hasData) return EmptySpeakersView();

      if (snapshot.hasData) return buildSpeakers(_, snapshot.data);

      return Text('Nothing to show: ${snapshot.error}');
    };

    return Scaffold(
      appBar: appBar,
      body: StreamBuilder(stream: model.speakers, builder: builder),
    );

  }

}
