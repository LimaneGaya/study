import 'dart:math';

import 'package:flutter/material.dart';

class Rotation extends StatefulWidget {
  const Rotation({super.key});

  @override
  State<Rotation> createState() => _RotationState();
}

class _RotationState extends State<Rotation>  with SingleTickerProviderStateMixin  {

    late AnimationController cont =
      AnimationController(vsync: this, duration: Duration(seconds: 2))
        ..repeat();
  late Animation<double> anim =
      Tween<double>(begin: 0, end: pi * 2).animate(cont);

  @override
  void dispose() {
    cont.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: anim,
            builder: (context, child) => Transform(
              transform: Matrix4.identity()..rotateY(anim.value),
              alignment: Alignment.center,
              child: child,
            ),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        floatingActionButton: BackButton(),
      );
  }
}