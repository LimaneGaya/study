import 'package:flutter/material.dart';

import '1 - simple rotation animation/rotation.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void moveTo(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
            child: ListView(
          children: [
            ListTile(
              title: Text("1 - Simple Rotation"),
              onTap: () => moveTo(Rotation()),
            ),
            ListTile(),
          ],
        )),
      ),
    );
  }
}
