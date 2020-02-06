import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/views/detail/detail_content.dart';
import 'package:letsattend/views/detail/detail_header.dart';

import 'package:lipsum/lipsum.dart' as lipsum;


class Detail extends StatefulWidget {

  final Event event;

  static final String title = lipsum.createParagraph(numSentences: 1);
  static final String abstract = lipsum.createText(numParagraphs: 6);

  Detail({ this.event });

  @override
  DetailState createState() => DetailState();

}

/// A simple colored screen with a centered text
class DetailState extends State<Detail> with SingleTickerProviderStateMixin {

  bool isVisible = true;
  ScrollController scrollController = new ScrollController();

  Animation<double> buttonAnimation;
  AnimationController animationCtrl;

  updateFloatingButtonVisibility(){

    ScrollDirection direction = scrollController.position.userScrollDirection;
    bool shouldBeVisible = direction == ScrollDirection.forward;

    if (isVisible != shouldBeVisible) {
      setState(() => isVisible = shouldBeVisible);
      shouldBeVisible ? animationCtrl.forward(): animationCtrl.animateBack(0);
    }

  }

  @override
  initState() {
    super.initState();

    animationCtrl = AnimationController(
      vsync: this,
      value: 0.1,
      duration: Duration(milliseconds: 400),
    );

    buttonAnimation = CurvedAnimation(
        parent: animationCtrl,
        curve: Curves.linear
    );

    animationCtrl.forward();
    scrollController.addListener(updateFloatingButtonVisibility);
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Event event = widget.event;

    final spaceBar = FlexibleSpaceBar(
      background: DetailHeader(event: event),
      collapseMode: CollapseMode.pin,
    );

    final appBar = SliverAppBar(
      expandedHeight: 320,
      flexibleSpace: spaceBar,
    );

    final scrollView = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool scrolled) => [appBar],
      body: DetailContent(event: event),
      controller: scrollController,
    );

    final floatingButton = FloatingActionButton(
      child: Icon(Icons.save),
      tooltip: 'Agregar a la agenda',
      foregroundColor: Colors.white,
      backgroundColor: event.color,
      onPressed: () => print('TODO: Add to agenda'),
    );

    final animatedFloatingButton = ScaleTransition(
      scale: buttonAnimation,
      child: floatingButton,
    );

    final scaffold = Scaffold(
      body: scrollView,
      floatingActionButton: animatedFloatingButton
    );

    return SafeArea(top: false, child: scaffold);

  }

}
