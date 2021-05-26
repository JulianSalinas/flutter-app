import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/router/routes.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/blocs/schedule_bloc.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/views/events/events_view.dart';
import 'package:letsattend/views/schedule/schedule_tab.dart';
import 'package:letsattend/widgets/custom/colored_flex.dart';
import 'package:letsattend/widgets/custom/formal_text.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ScheduleView extends StatefulWidget {
  @override
  ScheduleViewState createState() => ScheduleViewState();
}

class ScheduleViewState extends State<ScheduleView> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    final ScheduleBloc scheduleModel = Provider.of<ScheduleBloc>(context);

    final streamBuilder = StreamBuilder(
      stream: scheduleModel.stream,
      builder: buildStream,
    );

    return Scaffold(
      drawer: DrawerView(Routes.scheduleRoute),
      body: streamBuilder,
      extendBodyBehindAppBar: true,
    );

  }

  Widget buildStream(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError)
      return Center(child: Text('Error: ${snapshot.error}'));

    if(snapshot.hasData)
      return buildSchedule(context, snapshot.data);

    if (snapshot.connectionState == ConnectionState.waiting)
      return Center(child: CircularProgressIndicator());

    return Text('Nothing to show: ${snapshot.error}');
  }

  Widget buildSchedule(BuildContext context, Map<dynamic, List<Event>> schedule){

    final ScheduleBloc model = Provider.of<ScheduleBloc>(context);
    final SettingsBloc settings = Provider.of<SettingsBloc>(context);
    final labelColor = settings.nightMode ? Colors.white : SharedColors.edepa;

    final indicatorBorder = BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    );

    final indicatorDecoration = BoxDecoration(
      borderRadius: indicatorBorder,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    final scheduleTabs = schedule.entries
        .map((entry) => ScheduleTab(entry.key.toString()))
        .toList();

    final tabBar = TabBar(
      tabs: scheduleTabs,
      isScrollable: true,
      labelColor: labelColor,
      indicator: indicatorDecoration,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
    );

    final buttons = [
      IconButton(
        icon: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(model.orderedByType ? 0: math.pi),
          child: Icon(MaterialCommunityIcons.rotate_3d),
        ),
        onPressed: () => model.orderedByType = !model.orderedByType,
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => print('view'),
      ),
    ];

    // final appBar = AppBar(
    //   actions: buttons,
    //   centerTitle: true,
    //   backgroundColor: Colors.transparent,
    //   title: FormalText('Cronograma'),
    //   flexibleSpace: ColoredFlex(),
    //   elevation: 0,
    //   bottom: tabBar,
    // );

    final appBar = SliverAppBar(
      title: FormalText('Cronograma'),
      centerTitle: true,
      flexibleSpace: ColoredFlex(),
      bottom: tabBar,
      elevation: 0,
      actions: buttons,
    );

    final eventsView = (entry) {
      return EventsView(
        events: entry.value,
        toggleFavorite: model.toggleFavorite,
      );
    };

    final tabBarView = TabBarView(
      children: schedule.entries.map(eventsView).toList(),
    );

    final customScroll = NestedScrollView(

      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: appBar,
          ),
        ];
      },
      body: tabBarView,

    );

    return DefaultTabController(
      child: customScroll,
      length: schedule.length,
    );

  }

  @override
  void dispose() {
    final ScheduleBloc model = Provider.of<ScheduleBloc>(context);
    model.dispose();
    super.dispose();
  }

}
