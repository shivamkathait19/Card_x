import 'package:flutter/material.dart';
import 'dart:async';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() {
  runApp(MaterialApp(home: LoadingShowcase()));
}

class LoadingShowcase extends StatefulWidget {
  @override
  _LoadingShowcaseState createState() => _LoadingShowcaseState();
}

class _LoadingShowcaseState extends State<LoadingShowcase> {
  int currentIndex = 0;
  late Timer timer;

  final List<Widget> loaders = [
    // 1. Circular Loader
    CircularProgressIndicator(
      color: Colors.deepPurple,
      strokeWidth: 6,
    ),

    // 2. Jumping Dots
    JumpingDots(),

    // 3. Liquid Loader
    SizedBox(
      width: 100,
      height: 100,
      child: LiquidCircularProgressIndicator(
        value: 0.5,
        valueColor: AlwaysStoppedAnimation(Colors.orange),
        backgroundColor: Colors.white,
        borderColor: Colors.purple,
        borderWidth: 2.0,
        direction: Axis.vertical,
        center: Text("Loading"),
      ),
    ),

    // 4. Color Bars
    ColorBars(),

    // 5. Spinning Emoji Loader
    RotatingEmoji(),
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (_) {
      setState(() {
        currentIndex = (currentIndex + 1) % loaders.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: loaders[currentIndex],
        ),
      ),
    );
  }
}

class JumpingDots extends StatefulWidget {
  @override
  _JumpingDotsState createState() => _JumpingDotsState();
}

class _JumpingDotsState extends State<JumpingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> animations;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: Duration(milliseconds: 600), vsync: this)
      ..repeat(reverse: true);

    animations = List.generate(
      3,
          (i) => Tween<double>(begin: 0, end: -10).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.2, 1, curve: Curves.easeInOut),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, animation.value),
        child: child,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: animations.map(buildDot).toList(),
    );
  }
}

class ColorBars extends StatefulWidget {
  @override
  _ColorBarsState createState() => _ColorBarsState();
}

class _ColorBarsState extends State<ColorBars>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    animations = List.generate(
      5,
          (i) => Tween<double>(begin: 10, end: 40).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.1, 1, curve: Curves.easeInOut),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildBar(Animation<double> animation, Color color) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: 10,
        height: animation.value,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.purple
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        5,
            (i) => buildBar(animations[i], colors[i]),
      ),
    );
  }
}

class RotatingEmoji extends StatefulWidget {
  @override
  _RotatingEmojiState createState() => _RotatingEmojiState();
}

class _RotatingEmojiState extends State<RotatingEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
    AnimationController(vsync: this, duration: Duration(seconds: 2))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Text(
        "😂",
        style: TextStyle(fontSize: 60),
      ),
    );
  }
}
