import 'package:flutter/foundation.dart' show immutable;

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;
  const Person({required this.name, required this.age, required this.emoji});
}

const people = [
  Person(name: "Mark", age: 20, emoji: "🧔🏻"),
  Person(name: "Gaya", age: 27, emoji: "🧔🏽"),
  Person(name: "You", age: 33, emoji: "🧔🏾"),
];
