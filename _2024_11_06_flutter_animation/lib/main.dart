import 'package:flutter/material.dart';

import '1 - simple rotation animation/rotation.dart';
import '2 - chained animations/rotation.dart';
import '3 - 3D animation/animation3d.dart';
import '4 - hero animation/heroanimation.dart';
import '5 - implicit animations/implicit.dart';
import '6 - tween animation builder/tween_animation.dart';
import '7 - custom painter and animation/custom_painter.dart';
import '8 - 3d drawer/drawer.dart';
import '9 - animated prompt/animated_prompt.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        home: App());
  }
}

class App extends StatelessWidget {
  const App({super.key});
  void moveTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text("1 - Simple Rotation"),
              onTap: () => moveTo(context, Rotation()),
            ),
            ListTile(
              title: Text("2 - Advanced Rotation"),
              onTap: () => moveTo(context, AdvancedRotation()),
            ),
            ListTile(
              title: Text("3 - 3D Animation"),
              onTap: () => moveTo(context, Animation3D()),
            ),
            ListTile(
              title: Text("4 - Hero Animation"),
              onTap: () => moveTo(context, HeroAnimation()),
            ),
            ListTile(
              title: Text("5 - Implicit Animation"),
              onTap: () => moveTo(context, ImplicitAnimation()),
            ),
            ListTile(
              title: Text("6 - Tween Animation Builder"),
              onTap: () => moveTo(context, TweenAnimation()),
            ),
            ListTile(
              title: Text("7 - Custom Painter Animation"),
              onTap: () => moveTo(context, CustomPainterScreen()),
            ),
            ListTile(
              title: Text("8 - 3D Drawer"),
              onTap: () => moveTo(context, Drawer3D()),
            ),
            ListTile(
              title: Text("9 - Animated Prompt"),
              onTap: () => moveTo(context, AnimatedPrompt()),
            ),
          ],
        ),
      ),
    );
  }
}
