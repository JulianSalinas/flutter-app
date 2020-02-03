import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/locator.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/view_models/schedule_model.dart';
import 'package:letsattend/views/drawer/drawer_view.dart';
import 'package:letsattend/views/events/events_view.dart';
import 'package:letsattend/views/schedule/schedule_tab.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math; // import this
import 'package:letsattend/view_models/theme_model.dart';

class Schedule extends StatelessWidget {
  Widget buildStream(BuildContext context, ScheduleModel model, _) {
    return StreamBuilder(
      stream: model.events,
      builder: (context, snapshot) => ScheduleView(snapshot),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScheduleModel>(
      create: (context) => locator<ScheduleModel>(),
      child: Consumer<ScheduleModel>(builder: buildStream),
    );
  }
}

class ScheduleView extends StatefulWidget {
  final AsyncSnapshot<Map<dynamic, List<Event>>> snapshot;

  ScheduleView(this.snapshot);

  @override
  ScheduleViewState createState() => ScheduleViewState();
}

class ScheduleViewState extends State<ScheduleView>
    with TickerProviderStateMixin {
  bool isMenuOpen = false;
  AnimationController menuCtrl;

  @override
  void initState() {
    super.initState();
    menuCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    menuCtrl.dispose();
    super.dispose();
  }

//    if (snapshot.hasError)
//      return Text('Error: ${snapshot.error}');
//
//    final isWaiting = snapshot.connectionState == ConnectionState.waiting;
//
//    if (isWaiting && !snapshot.hasData)
//      return Text('Loading data...');
//
//    if (snapshot.hasData)
//      return buildBar()_, snapshot.data);

  @override
  Widget build(BuildContext context) {

    final themeModel = Provider.of<ThemeModel>(context);
    final scheduleModel = Provider.of<ScheduleModel>(context);

    final labelColor =
        themeModel.nightMode ? Colors.white : SharedColors.kashmir[0];

    final indicatorBorder = BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    );

    final indicatorDecoration = BoxDecoration(
      borderRadius: indicatorBorder,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    final scheduleTab = (entry) => ScheduleTab(entry.key.toString());

    final scheduleTabs = widget.snapshot.hasData
        ? widget.snapshot.data.entries.map(scheduleTab).toList()
        : [Text('NO EVENTOS')];

    final tabBar = TabBar(
      tabs: scheduleTabs,
      isScrollable: true,
      labelColor: labelColor,
      indicator: indicatorDecoration,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
    );

    final appBarGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: SharedColors.kashmir,
    );

    final appBarContent = Container(
      decoration: BoxDecoration(gradient: appBarGradient),
    );

    final appBar = SliverAppBar(
      title: ModernText(
        'Cronograma',
        color: Colors.white,
      ),
      centerTitle: true,
      flexibleSpace: appBarContent,
      bottom: tabBar,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(scheduleModel.orderedByType ? 0: math.pi),
            child: Icon(MaterialCommunityIcons.rotate_3d_variant),
          ),
          onPressed: () => scheduleModel.orderedByType = !scheduleModel.orderedByType,
        ),
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () => print('view'),
        ),
      ],
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: menuCtrl,
        ),
        onPressed: () {
          setState(() {
            isMenuOpen = !isMenuOpen;
            isMenuOpen ? menuCtrl.reverse() : menuCtrl.forward();
          });
        },
      ),
    );

    final eventsView = (entry) {
      return EventsView(
        key: Key(entry.key),
        events: entry.value,
      );
    };

    final tabBarView = TabBarView(
      children: widget.snapshot.hasData
          ? widget.snapshot.data.entries.map(eventsView).toList()
          : [Text('NO EVENTOS')],
    );

    final customScroll = CustomScrollView(
      slivers: [
        appBar,
        SliverFillRemaining(child: tabBarView),
      ],
    );

    final tabController = DefaultTabController(
      child: customScroll,
      length: widget.snapshot.hasData ? widget.snapshot.data.length : 1,
    );

    return Scaffold(
      drawer: DrawerView(),
      body: tabController,
      extendBodyBehindAppBar: true,
    );
  }
}
