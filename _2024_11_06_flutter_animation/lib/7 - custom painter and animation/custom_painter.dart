import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterScreen extends StatefulWidget {
  const CustomPainterScreen({super.key});

  @override
  State<CustomPainterScreen> createState() => _CustomPainterScreenState();
}

typedef STPSM = SingleTickerProviderStateMixin<CustomPainterScreen>;

class _CustomPainterScreenState extends State<CustomPainterScreen> with STPSM {
  late final AnimationController _sidesCont = AnimationController(
    vsync: this,
    duration: Duration(seconds: 5),
  );

  late final Animation<int> _sidesAnim =
      IntTween(begin: 3, end: 10).animate(_sidesCont);

  late final Animation<double> _rotatAnim =
      Tween<double>(begin: 0, end: pi * 6)
          .animate(_sidesCont);
          late final Animation<double> _radiusAnim =
      Tween<double>(begin: 1, end: 5)
          .chain(CurveTween(curve: Curves.bounceInOut))
          .animate(_sidesCont);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sidesCont.repeat(reverse: true);
  }

  @override
  void dispose() {
    _sidesCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _sidesAnim,
            _rotatAnim,
            _radiusAnim
          ]),
          builder: (context, child) => Transform(
            transform: Matrix4.identity()
              ..rotateX(_rotatAnim.value)
              ..rotateY(_rotatAnim.value)
              ..rotateZ(_rotatAnim.value),
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / _radiusAnim.value,
              height: MediaQuery.of(context).size.width / _radiusAnim.value,
              child: CustomPaint(
                painter: MyPainter(sides: _sidesAnim.value),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final int sides;
  MyPainter({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    final path = Path();

    final center = Offset(size.width / 2, size.height / 2);
    final angle = 2 * pi / sides;
    final radius = size.width / 2;

    final angles = List.generate(sides, (index) => index * angle);

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );
    for (double theta in angles) {
      path.lineTo(
        center.dx + radius * cos(theta),
        center.dy + radius * sin(theta),
      );
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is MyPainter && oldDelegate.sides != sides;
}
