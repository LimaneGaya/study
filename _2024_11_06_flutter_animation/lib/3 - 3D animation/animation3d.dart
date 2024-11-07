import 'dart:math' show pi;

import 'package:flutter/material.dart';

class Animation3D extends StatefulWidget {
  const Animation3D({super.key});

  @override
  State<Animation3D> createState() => _Animation3DState();
}

const double d = 100;

class _Animation3DState extends State<Animation3D>
    with TickerProviderStateMixin {
  late final AnimationController _xCont;
  late final AnimationController _yCont;
  late final AnimationController _zCont;

  final Tween<double> anim = Tween<double>(begin: 0, end: pi * 2);

  @override
  void initState() {
    super.initState();
    _xCont = AnimationController(vsync: this, duration: Duration(seconds: 40));
    _yCont = AnimationController(vsync: this, duration: Duration(seconds: 50));
    _zCont = AnimationController(vsync: this, duration: Duration(seconds: 60));
  }

  @override
  void dispose() {
    _xCont.dispose();
    _yCont.dispose();
    _zCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xCont
      ..reset()
      ..forward();
    _yCont
      ..reset()
      ..forward();
    _zCont
      ..reset()
      ..forward();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100, width: double.infinity),
          AnimatedBuilder(
            animation: Listenable.merge([_xCont, _yCont, _zCont]),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(anim.evaluate(_xCont))
                  ..rotateY(anim.evaluate(_yCont))
                  ..rotateZ(anim.evaluate(_zCont)),
                alignment: Alignment.center,
                child: child,
              );
            },
            child: Stack(
              children: [
                Container(color: Colors.red, height: d, width: d),
                Transform(
                  transform: Matrix4.identity()..translate(0, 0, d),
                  alignment: Alignment.center,
                  child: Container(color: Colors.green, height: d, width: d),
                ),
                Transform(
                  transform: Matrix4.identity()..rotateY(-pi / 2),
                  alignment: Alignment.centerLeft,
                  child: Container(color: Colors.blue, height: d, width: d),
                ),
                Transform(
                  transform: Matrix4.identity()..rotateY(pi / 2),
                  alignment: Alignment.centerRight,
                  child: Container(color: Colors.purple, height: d, width: d),
                ),
                Transform(
                  transform: Matrix4.identity()..rotateX(-pi / 2),
                  alignment: Alignment.bottomCenter,
                  child: Container(color: Colors.yellow, height: d, width: d),
                ),
                Transform(
                  transform: Matrix4.identity()..rotateX(pi / 2),
                  alignment: Alignment.topCenter,
                  child: Container(color: Colors.pink, height: d, width: d),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
