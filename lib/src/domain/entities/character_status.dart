import 'package:flutter/material.dart';

enum CharacterStatus {
  alive,
  dead,
  unknown,
  none;

  bool get isAlive => this == alive;
  bool get isDead => this == dead;
  bool get isUnknown => this == unknown;
  bool get isNone => this == none;

  String get name {
    switch (this) {
      case CharacterStatus.alive:
        return 'Alive';
      case CharacterStatus.dead:
        return 'Dead';
      case CharacterStatus.unknown:
        return 'unknown';
      case CharacterStatus.none:
        return '';
    }
  }

  Color get color {
    switch (this) {
      case CharacterStatus.alive:
        return Colors.green;
      case CharacterStatus.dead:
        return Colors.red;
      case CharacterStatus.unknown:
        return Colors.grey;
      case CharacterStatus.none:
        return Colors.grey;
    }
  }

  static List<CharacterStatus> get valuesList => CharacterStatus.values
      .where((status) => status != CharacterStatus.none)
      .toList();
}
