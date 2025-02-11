import 'dart:io';
import 'dart:ui' show ImageByteFormat;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PrintWidget());
  }
}

class PrintWidget extends StatefulWidget {
  const PrintWidget({super.key});

  @override
  State<PrintWidget> createState() => _PrintWidgetState();
}

class _PrintWidgetState extends State<PrintWidget> {
  bool _isBig = true;
  GlobalKey k = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((time) async {
      final render = k.currentContext?.findRenderObject();
      if (render is! RenderRepaintBoundary) return;
      final image = render.toImageSync();
      final out = await image.toByteData(format: ImageByteFormat.png);
      File("$time.png").writeAsBytesSync(out!.buffer.asUint8List());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RepaintBoundary(
          key: k,
          child: Container(
            width: 300,
            height: 300,
            color: Colors.green,
            child: Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 10),
                width: _isBig ? 200 : 100,
                height: _isBig ? 200 : 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(_isBig ? 60 : 30),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () => setState(() => _isBig = !_isBig),
      ),
    );
  }
}

