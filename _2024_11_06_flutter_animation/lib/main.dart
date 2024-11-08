import 'package:flutter/material.dart';
import 'package:flutter_animation/5%20-%20implicit%20animations/implicit.dart';

import '1 - simple rotation animation/rotation.dart';
import '2 - chained animations/rotation.dart';
import '3 - 3D animation/animation3d.dart';
import '4 - hero animation/heroanimation.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: App()
    );
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
          ],
        ),
      ),
    );
  }
}
