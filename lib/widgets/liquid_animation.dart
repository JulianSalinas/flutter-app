import 'package:flutter/material.dart';
import 'dart:math';

class LiquidAnimation extends StatefulWidget {

  /// Specifies the duration the text should fill with liquid.
  ///
  /// By default it is set to 6 seconds.
  final Duration loadDuration;

  /// Specifies the duration that one wave takes to pass the screen.
  ///
  /// By default it is set to 2 seconds.
  final Duration waveDuration;

  /// Specifies the height of the box around text
  ///
  /// By default it is set to 250
  final double boxHeight;

  /// Specifies the width of the box around text
  ///
  /// By default it is set to 400
  final double boxWidth;

  /// Specifies the backgroundColor of the box
  ///
  /// By default it is set to black color
  final Color boxBackgroundColor;

  /// Specifies the color of the wave
  ///
  /// By default it is set to blueAccent color
  final Color waveColor;

  LiquidAnimation({
    Key key,
    this.loadDuration,
    this.waveDuration,
    this.boxHeight,
    this.boxWidth,
    this.boxBackgroundColor,
    this.waveColor,
  }) : super(key: key);

  @override
  _LiquidAnimationState createState() => new _LiquidAnimationState();
}

class _LiquidAnimationState extends State<LiquidAnimation>
    with TickerProviderStateMixin {

  Duration _waveDuration;
  Duration _loadDuration;

  Color _waveColor;
  double _boxWidth;
  double _boxHeight;

  Animation _loadValue;
  AnimationController _waveController;
  AnimationController _loadController;

  @override
  void initState() {
    super.initState();

    _boxWidth = widget.boxWidth ?? 400;
    _boxHeight = widget.boxHeight ?? 250;

    _waveDuration = widget.waveDuration ?? Duration(milliseconds: 2000);
    _loadDuration = widget.loadDuration ?? Duration(milliseconds: 6000);

    _waveController = AnimationController(
      vsync: this,
      duration: _waveDuration,
    );

    _loadController = AnimationController(
      vsync: this,
      duration: _loadDuration,
    );

    _waveColor = widget.waveColor ?? Colors.blueAccent;

    _loadValue = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(_loadController);

    _waveController.repeat();
    _loadController.forward();
  }

  @override
  void dispose() {
    if (_waveController != null)
      _waveController
        ..stop()
        ..dispose();

    if (_loadController != null)
      _loadController
        ..stop()
        ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final animatedBuilder = AnimatedBuilder(
      animation: _waveController,
      builder: (BuildContext context, Widget child) {
        return CustomPaint(
          painter: WavePainter(
            waveAnimation: _waveController,
            percentValue: _loadValue.value,
            boxHeight: _boxHeight,
            waveColor: _waveColor,
          ),
        );
      },
    );

    return SizedBox(
      height: _boxHeight,
      width: _boxWidth ?? MediaQuery.of(context).size.width,
      child: animatedBuilder,
    );
  }

}

class WavePainter extends CustomPainter {

  Color waveColor;
  double boxHeight;
  double percentValue;
  Animation<double> waveAnimation;

  WavePainter({
    this.boxHeight,
    this.waveColor,
    this.percentValue,
    this.waveAnimation,
  });

  @override
  void paint(Canvas canvas, Size size) {

    double width = (size.width != null) ? size.width : 200;
    double height = (size.height != null) ? size.height : 200;

    Paint wavePaint = Paint()..color = waveColor;

    double _textHeight = 48;

    double _percent = percentValue / 100.0;
    double _baseHeight =
        (boxHeight / 2) + (_textHeight / 2) - (_percent * _textHeight);

    Path path = Path();
    path.moveTo(0.0, _baseHeight);

    for (double i = 0.0; i < width; i++) {
      double form = sin((i / width * 2 * pi) + (waveAnimation.value * 2 * pi));
      path.lineTo(i, _baseHeight + form * 8);
    }

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter _) {
    return true;
  }

}
