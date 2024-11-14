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
  late final AnimationController _xCont = AnimationController(
      vsync: this,
      duration: Duration(seconds: 40),
      animationBehavior: AnimationBehavior.preserve);
  late final AnimationController _yCont = AnimationController(
      vsync: this,
      duration: Duration(seconds: 50),
      animationBehavior: AnimationBehavior.preserve);
  late final AnimationController _zCont = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
      animationBehavior: AnimationBehavior.preserve);

  final Tween<double> anim = Tween<double>(begin: 0, end: pi * 2);

  @override
  void dispose() {
    _xCont.dispose();
    _yCont.dispose();
    _zCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      _xCont
        ..reset()
        ..forward();
      _yCont
        ..reset()
        ..forward();
      _zCont
        ..reset()
        ..forward();
    });

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
                  transform: Matrix4.translationValues(0, 0, d),
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
      floatingActionButton: BackButton(),
    );
  }
}
