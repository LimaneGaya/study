import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  bool _isZoomedIn = false;
  final double w = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          AnimatedContainer(
            curve: Curves.bounceOut,
            width: _isZoomedIn ? w : MediaQuery.of(context).size.width,
            duration: Durations.medium3,
            child: Image.asset(
              "assets/images/bday.png",
              height: _isZoomedIn ? 100 : 300,
              fit: BoxFit.fitWidth,
            ),
          ),
          TextButton(
            onPressed: () => setState(() => _isZoomedIn = !_isZoomedIn),
            child: Text(_isZoomedIn ? "Zoom in" : "Zoom out"),
          ),
        ],
      ),
      floatingActionButton: BackButton(),
    );
  }
}
