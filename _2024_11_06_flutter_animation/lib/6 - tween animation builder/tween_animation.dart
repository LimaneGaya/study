import 'dart:math';

import 'package:flutter/material.dart';

class TweenAnimation extends StatefulWidget {
  const TweenAnimation({super.key});

  @override
  State<TweenAnimation> createState() => _TweenAnimationState();
}

class _TweenAnimationState extends State<TweenAnimation> {
  Color _color = randomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: const CircleClipper(),
          child: TweenAnimationBuilder(
            tween: ColorTween(begin: _color, end: randomColor()),
            duration: Duration(seconds: 5),
            onEnd: () => setState(() => _color = randomColor()),
            builder: (context, value, child) => Container(
              color: value,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}

Color randomColor() => Color(0xFF000000 + Random().nextInt(0x00FFFFFF));

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final w = size.width / 2;
    final rect = Rect.fromCircle(center: Offset(w, w), radius: w);
    path.addOval(rect);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
