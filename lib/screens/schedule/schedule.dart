import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors/ui_gradients.dart';
import 'package:letsattend/shared/switch/night_switch.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/screens/schedule/date_page.dart';
import 'package:letsattend/screens/schedule/date_tab.dart';
import 'package:letsattend/shared/text/modern_text.dart';


class Schedule extends StatefulWidget {
  @override
  ScheduleState createState() => ScheduleState();
}

class ScheduleState extends State<Schedule> with SingleTickerProviderStateMixin {

  TabController tabCtrl;

  static final DateTime seedDate = DateTime.now();

  final List<DateTime> dates = <DateTime>[
    seedDate,
    seedDate.add(Duration(days: 1)),
    seedDate.add(Duration(days: 2)),
    seedDate.add(Duration(days: 3)),
    seedDate.add(Duration(days: 4)),
  ];

  @override
  void initState() {
    super.initState();
    tabCtrl = new TabController(vsync: this, length: dates.length);
  }

  @override
  void dispose() {
    tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);
    final labelColor = scheme.nightMode ? Colors.white : UIGradients.kashmir[1];

    final tabs = dates.map((DateTime dateTime) {
      return DateTab(dateTime: dateTime);
    }).toList();

    final pages = dates.map((DateTime dateTime) {
      return DatePage(date: dateTime);
    }).toList();

    final indicatorBorder = BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    );

    final indicator = BoxDecoration(
      borderRadius: indicatorBorder,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    final tabBar = TabBar(
      controller: tabCtrl,
      indicator: indicator,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      labelColor: labelColor,
      tabs: tabs,
      unselectedLabelColor: Colors.white,
    );

    final content = TabBarView(
      children: pages,
      controller: tabCtrl,
    );

    final appBarGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: UIGradients.kashmir,
    );

    final appBarContent = Container(
      height: 140,
      decoration: BoxDecoration(gradient: appBarGradient),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Icon(Icons.android, size: 76, color: Colors.white,)
        ],
      ),
    );

    final spaceBar = FlexibleSpaceBar(
      background: appBarContent,
      collapseMode: CollapseMode.parallax,
    );

    final appBar = SliverAppBar(
      expandedHeight: 240,
      title: ModernText('Cronograma', color: Colors.white,),
      centerTitle: true,
      flexibleSpace: spaceBar,
      bottom: tabBar,
      elevation: 0,
      floating: false,
      backgroundColor: UIGradients.kashmir[1],
    );

    final scrollView = NestedScrollView(
      body: content,
      headerSliverBuilder: (BuildContext context, bool scrolled) => [appBar],
    );

    return  Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: scrollView,),
          NightSwitch(),
        ],
      ),
    );

  }
}
