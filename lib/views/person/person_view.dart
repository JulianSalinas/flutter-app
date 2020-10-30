import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/blocs/speakers_bloc.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/views/events/events_view.dart';
import 'package:letsattend/views/person/person_header.dart';
import 'package:letsattend/views/speakers/speaker_widget.dart';
import 'package:provider/provider.dart';


class PersonView extends StatefulWidget {

  final Speaker speaker;

  PersonView({ this.speaker });

  @override
  PersonViewState createState() => PersonViewState();

}

/// A simple colored screen with a centered text
class PersonViewState extends State<PersonView> with SingleTickerProviderStateMixin{

  final SpeakersBloc _speakersService = locator<SpeakersBloc>();

  bool isLoading = true;
  List<Event> events = [];

  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    /// Some people may not have related events
    if(widget.speaker.eventKeys == null) {
      isLoading = false;
      return;
    }

    final keys = widget.speaker.eventKeys.keys.toList();
    _speakersService.getEvents(keys).then(onEventsChange);

  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  toggleFavorite(Event event) async {
    await _speakersService.toggleFavorite(event);
    setState(() { event.isFavorite = !event.isFavorite; });
  }

  onEventsChange(List<Event> events) {
    this.events = events.where((event) => event != null).toList();
    setState(() { this.isLoading = false; });
  }

  changePage() {
    int pageIndex = _pageController.page == 0 ? 1 : 0;
    setState(() { currentPage = pageIndex; });
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsBloc>(context);

    final spaceBar = FlexibleSpaceBar(
      background: PersonHeader(speaker: widget.speaker),
      collapseMode: CollapseMode.pin,
    );

    final appBar = SliverAppBar(
      expandedHeight: 256, //320
      flexibleSpace: spaceBar,
    );

    final loading = Center(
      child: CircularProgressIndicator(),
    );

    final body = isLoading
        ? loading
        : EventsView(
          events: events,
          toggleFavorite: toggleFavorite
        );

    final titleIcon = Icon(
      _pageController.page == 0
          ? Icons.keyboard_arrow_right
          : Icons.keyboard_arrow_left,
    );

    final tilePrefix = currentPage == 0 ? 'Acerca' : 'Eventos';

    final tile = ListTile(
      title: Text('$tilePrefix de ${widget.speaker.firstName}'),
      trailing: _pageController.page == 0 ? Icon(Icons.keyboard_arrow_right) : null,
      leading: _pageController.page == 1 ? Icon(Icons.keyboard_arrow_left) : null,
      onTap: changePage
    );

    final tile2 = InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Text('$tilePrefix de ${widget.speaker.firstName}'),
            titleIcon,
          ],
        ),
      ),
      onTap: changePage,
    );

    final inkTitle = Ink(
      color: Colors.grey.withOpacity(0.05),
      child: tile2,
    );

    final aboutPage = Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Acerca de ${widget.speaker.firstName}',
            style: Typography.englishLike2018.headline6
          ),
          Divider(),
          Text(
              widget.speaker.about,
              style: Typography.englishLike2018.bodyText1
          ),
        ],
      ),
    );

    final pagerView = Flexible(child: PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        body,
        Flexible(child: aboutPage)
      ],
    ));

    final scrollView = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool scrolled) => [appBar],
      body: Column(children: [inkTitle, pagerView]),
    );

    final scaffold = Scaffold(
      body: scrollView,
    );

    return SafeArea(top: false, child: scaffold);

  }

}
