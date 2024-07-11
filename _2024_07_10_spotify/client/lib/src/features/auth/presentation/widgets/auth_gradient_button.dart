import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: buttonGradientRadius,
          fixedSize: Size.fromWidth(constraints.maxWidth),
          backgroundBuilder: (context, _, child) {
            return DecoratedBox(
              decoration: buttonGradientDecoration,
              child: child,
            );
          },
        ),
        onPressed: onPressed,
        child: Text(text, style: buttonGradientStyle),
      );
    });
  }
}
