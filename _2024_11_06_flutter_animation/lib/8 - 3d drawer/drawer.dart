import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Drawer3D extends StatelessWidget {
  const Drawer3D({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.blueGrey.shade900,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(title: Text('List Item number: $index'));
            },
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Drawer')),
        body: Container(
          color: Colors.blueGrey.shade900,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text("Drag towards  "), Icon(Icons.arrow_forward)],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  const MyDrawer({super.key, required this.child, required this.drawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

const t = Duration(milliseconds: 500);

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late final _contChild = AnimationController(vsync: this, duration: t);
  late final _animChild = Tween<double>(
    begin: 0,
    end: -pi / 2,
  ).animate(_contChild);

  late final _contDrawer = AnimationController(vsync: this, duration: t);
  late final _animDrawer = Tween<double>(
    begin: pi / 3,
    end: 0,
  ).animate(_contDrawer);

  @override
  void dispose() {
    _contChild.dispose();
    _contDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _contChild.value += delta;
        _contDrawer.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_contChild.value < 0.5) {
          _contChild.reverse();
          _contDrawer.reverse();
        } else {
          _contChild.forward();
          _contDrawer.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_contChild, _contDrawer]),
        builder: (context, child) {
          return Stack(
            children: [
              Container(color: Colors.brown.shade800),
              Transform(
                alignment: Alignment.centerLeft,
                transform:
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(_contChild.value * maxDrag)
                      ..rotateY(_animChild.value),
                child: widget.child,
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform:
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                        -screenWidth * 0.8 + _contDrawer.value * maxDrag,
                      )
                      ..rotateY(_animDrawer.value),
                child: widget.drawer,
              ),
            ],
          );
        },
      ),
    );
  }
}
