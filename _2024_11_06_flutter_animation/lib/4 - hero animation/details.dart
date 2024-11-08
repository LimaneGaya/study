import 'package:flutter/material.dart';
import 'package:flutter_animation/4%20-%20hero%20animation/person.dart';

class Details extends StatelessWidget {
  final Person person;
  const Details({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: person.name,
          child: Text(person.emoji, style: TextStyle(fontSize: 40)),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(person.name),
            SizedBox(height: 20),
            Text("${person.age} yo"),
          ],
        ),
      ),
    );
  }
}
