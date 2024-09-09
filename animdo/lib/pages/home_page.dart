import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;

  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);

  AnimationController? _startIconAnimationController;

  @override
  void initState() {
    _startIconAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    super.initState();
    _startIconAnimationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_circularAnimationButton(), _startIcon()],
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      curve: Curves.easeInOutCubicEmphasized,
      duration: const Duration(seconds: 1),
      builder: (_context, double _scale, _child) {
        return Transform.scale(scale: _scale, child: _child);
      },
      child: Container(
        color: Colors.red,
      ),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          curve: Curves.bounceIn,
          height: _buttonRadius,
          width: _buttonRadius,
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(_buttonRadius)),
          child: const Center(
            child: Text("Basic!",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _startIcon() {
    return AnimatedBuilder(
      animation: _startIconAnimationController!.view,
      builder: (_buildContext, _child){
        return Transform.rotate(angle: _startIconAnimationController!.value * 2 * pi, child: _child,);
      },
      child: const Icon(
        Icons.star,
        size: 150,
        color: Colors.yellow,
      ),
    );
  }
}
