import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors.dart';
import 'package:letsattend/views/schedule/date_page.dart';
import 'package:letsattend/views/schedule/date_tab.dart';
import 'package:letsattend/widgets/modern_text.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/controllers/theme_controller.dart';


class Schedule extends StatefulWidget {
  @override
  ScheduleState createState() => ScheduleState();
}

class ScheduleState extends State<Schedule> with TickerProviderStateMixin {

  TabController tabCtrl;
  AnimationController menuCtrl;

  bool isMenuOpen = false;

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
    tabCtrl = TabController(vsync: this, length: dates.length);
    menuCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    tabCtrl.dispose();
    menuCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<ThemeController>(context);
    final labelColor = scheme.nightMode ? Colors.white : FlatUI.kashmir[0];

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
      colors: FlatUI.kashmir,
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

    final appBar = AppBar(
//      expandedHeight: 240,
      title: ModernText('Cronograma', color: Colors.white,),
      centerTitle: true,
      flexibleSpace: spaceBar,
      bottom: tabBar,
      elevation: 0,
//      floating: false,
      backgroundColor: FlatUI.kashmir[1],
      actions: <Widget>[
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
      )
    );

    final scrollView = NestedScrollView(
      body: content,
      headerSliverBuilder: (BuildContext context, bool scrolled) => [appBar],
    );

    return  Scaffold(
      appBar: appBar,
      body: content,
    );

  }
}
