import 'package:flutter/material.dart';

import '1 - simple rotation animation/rotation.dart';
import '2 - chained animations/rotation.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: App(),
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
          ],
        ),
      ),
    );
  }
}
