import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/blocs/speakers_bloc.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/views/events/events_view.dart';
import 'package:letsattend/views/person/person_header.dart';
import 'package:letsattend/widgets/common/empty_view.dart';


class PersonView extends StatefulWidget {

  final Speaker speaker;

  PersonView({ this.speaker });

  @override
  PersonViewState createState() => PersonViewState();

}

/// A simple colored screen with a centered text
class PersonViewState extends State<PersonView> with SingleTickerProviderStateMixin{

  PageController _pageController;
  final SpeakersBloc _speakersService = locator<SpeakersBloc>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // _speakersService.getEvents(widget.speaker.eventKeys.keys.toList());
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  Widget buildEvents(_, AsyncSnapshot<List<Event>> snapshot) {

    if (snapshot.hasError)
      return EmptyView('Vacío', 'Error al cargar la información');

    if (snapshot.connectionState == ConnectionState.waiting)
      return Center(child: CircularProgressIndicator());

    if (snapshot.data.isEmpty)
      return EmptyView('Vacío', 'Esta persona no tiene eventos asociados');

    return EventsView(
      events: snapshot.data.where((event) => event != null).toList(),
      toggleFavorite: (event) { },
    );

  }

  Widget buildContent() {

    /// Speaker has no events associated
    if (widget.speaker.eventKeys == null || widget.speaker.eventKeys.isEmpty) {
      return EmptyView('Vacío', 'Esta persona no tiene eventos asociados');
    }

    /// Take into account some events could be null due to updates
    return FutureBuilder(
      initialData: List<Event>(),
      future: _speakersService.getEvents(widget.speaker.eventKeys.keys.toList()),
      builder: buildEvents,
    );

  }

  @override
  Widget build(BuildContext context) {

    final spaceBar = FlexibleSpaceBar(
      background: PersonHeader(speaker: widget.speaker),
      collapseMode: CollapseMode.pin,
    );

    final appBar = SliverAppBar(
      expandedHeight: 256, //320
      flexibleSpace: spaceBar,
    );

    final scrollView = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool scrolled) => [appBar],
      body: buildContent(),
    );

    final scaffold = Scaffold(
      body: scrollView,
    );

    return SafeArea(top: false, child: scaffold);

  }

}
