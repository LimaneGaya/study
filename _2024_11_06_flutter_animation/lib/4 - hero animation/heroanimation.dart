import 'package:flutter/material.dart';
import 'package:flutter_animation/4%20-%20hero%20animation/details.dart';

import 'person.dart';

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  void moveTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("People")),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: Hero(
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
                return Material(
                  color: Colors.transparent,
                  child: switch (flightDirection) {
                    HeroFlightDirection.pop => fromHeroContext.widget,
                    HeroFlightDirection.push => ScaleTransition(
                        scale: animation.drive(
                          Tween(begin: 0.0, end: 1.0)
                              .chain(CurveTween(curve: Curves.fastOutSlowIn)),
                        ),
                        child: toHeroContext.widget,
                      ),
                  },
                );
              },
              tag: person.name,
              child: Text(person.emoji, style: TextStyle(fontSize: 40)),
            ),
            title: Text(person.name),
            subtitle: Text("${person.age} yo"),
            onTap: () => moveTo(context, Details(person: person)),
          );
        },
      ),
    );
  }
}
