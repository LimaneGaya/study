import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AdvancedRotation extends StatefulWidget {
  const AdvancedRotation({super.key});

  @override
  State<AdvancedRotation> createState() => _AdvancedRotationState();
}

const Duration t = Duration(seconds: 1);
const double hp = pi / 2;

class _AdvancedRotationState extends State<AdvancedRotation>
    with TickerProviderStateMixin {
  late AnimationController rotCont =
      AnimationController(vsync: this, duration: t)
        ..addStatusListener(startFlipAnim)
        ..forward();

  late AnimationController flipCont =
      AnimationController(vsync: this, duration: t)
        ..addStatusListener(startRotAnim);

  late Animation<double> rotAnim = Tween<double>(begin: 0, end: -hp).animate(
    CurvedAnimation(parent: rotCont, curve: Curves.bounceOut),
  );
  late Animation<double> flipAnim = Tween<double>(begin: 0, end: pi).animate(
    CurvedAnimation(parent: flipCont, curve: Curves.bounceOut),
  );

  void startFlipAnim(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    Future.delayed(
      Duration(seconds: 1),
      () {
        final v = flipAnim.value;
        flipAnim = Tween<double>(begin: v, end: v + pi).animate(
          CurvedAnimation(parent: flipCont, curve: Curves.bounceOut),
        );
        flipCont
          ..reset()
          ..forward();
      },
    );
  }

  void startRotAnim(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    Future.delayed(Duration(seconds: 1), () {
      final v = rotAnim.value;
      rotAnim = Tween<double>(begin: v, end: v - pi / 2).animate(
        CurvedAnimation(parent: rotCont, curve: Curves.bounceOut),
      );
      rotCont
        ..reset()
        ..forward();
    });
  }

  @override
  void dispose() {
    rotCont.removeStatusListener(startFlipAnim);
    flipCont.removeStatusListener(startRotAnim);
    rotCont.dispose();
    flipCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: rotAnim,
          builder: (context, child) => Transform(
            transform: Matrix4.identity()..rotateZ(rotAnim.value),
            alignment: Alignment.center,
            child: child,
          ),
          child: AnimatedBuilder(
            animation: flipAnim,
            builder: (context, child) => Transform(
              transform: Matrix4.identity()..rotateY(flipAnim.value),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipPath(
                      clipper: ClipCircle(side: CircleSide.left),
                      child: Container(
                        width: 50,
                        height: 100,
                        color: Colors.red,
                      )),
                  ClipPath(
                      clipper: ClipCircle(side: CircleSide.right),
                      child: Container(
                        width: 50,
                        height: 100,
                        color: Colors.blue,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BackButton(),
    );
  }
}

enum CircleSide { left, right }

class ClipCircle extends CustomClipper<Path> {
  final CircleSide side;
  const ClipCircle({required this.side});

  @override
  getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockWise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }
    path.arcToPoint(
      offset,
      clockwise: clockWise,
      radius: Radius.elliptical(size.width, size.height / 2),
    );
    path.close();
    return path;
  }
}
