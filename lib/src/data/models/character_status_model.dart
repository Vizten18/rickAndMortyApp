// ignore_for_file: no_default_cases

import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

enum CharacterStatusModel {
  alive('Alive'),
  dead('Dead'),
  unknown('unknown'),
  none('none');

  const CharacterStatusModel(this.value);
  final String value;

  static CharacterStatusModel fromServer(String value) {
    switch (value) {
      case 'Alive':
        return CharacterStatusModel.alive;
      case 'Dead':
        return CharacterStatusModel.dead;
      case 'unknown':
        return CharacterStatusModel.unknown;
      default:
        return CharacterStatusModel.none;
    }
  }

  CharacterStatus toEntity() {
    switch (this) {
      case CharacterStatusModel.alive:
        return CharacterStatus.alive;
      case CharacterStatusModel.dead:
        return CharacterStatus.dead;
      case CharacterStatusModel.unknown:
        return CharacterStatus.unknown;
      case CharacterStatusModel.none:
        return CharacterStatus.none;
    }
  }
}
