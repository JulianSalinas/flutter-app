import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:letsattend/widgets/speaker_widget.dart';
import 'package:letsattend/view_models/theme_model.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
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
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
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

    final listDelegate = SliverChildBuilderDelegate(
      itemBuilder,
      childCount: itemCount,
    );

    return SliverList(delegate: listDelegate);

  }

  @override
  Widget build(BuildContext context) {
    final speakerModel = Provider.of<SpeakersModel>(context);
    final themeModel = Provider.of<ThemeModel>(context);

    final filterIcon = Icon(
      speakerModel.descending
          ? MaterialCommunityIcons.sort_ascending
          : MaterialCommunityIcons.sort_descending,
    );

    final filterButton = IconButton(
        icon: filterIcon,
        onPressed: () => speakerModel.descending = !speakerModel.descending);

    final searchButton = IconButton(
      icon: Icon(Icons.search),
      onPressed: startSearch,
    );

    final closeButton = IconButton(
      icon: Icon(Icons.close),
      onPressed: () => closeSearch(speakerModel),
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
      onChanged: (query) => speakerModel.filter = query,
    );

    final buttons = _isSearching ? [closeButton] : [filterButton, searchButton];

    final appBarGradient =  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.red, Colors.deepOrange],
        ),
      ),
    );

    final appBar = SliverAppBar(
      floating: true,
      actions: buttons,
      centerTitle: true,
      title: _isSearching ? searchInput : ModernText('Expositores'),
      flexibleSpace: themeModel.nightMode ? null : appBarGradient,
    );

    final builder = (_, snapshot) {
      if (snapshot.hasError) return Text('Error: ${snapshot.error}');

      final isWaiting = snapshot.connectionState == ConnectionState.waiting;

      if (isWaiting && !snapshot.hasData) return EmptySpeakersView();

      if (snapshot.hasData) return buildSpeakers(_, snapshot.data);

      return Text('Nothing to show: ${snapshot.error}');
    };

    final customScroll = CustomScrollView(
      slivers: <Widget>[
        appBar,
        StreamBuilder(stream: speakerModel.speakers, builder: builder),
      ],
    );

    return Scaffold(
      drawer: DrawerView(),
      body: customScroll,
    );

  }

}
