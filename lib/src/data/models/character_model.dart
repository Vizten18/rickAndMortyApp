import 'package:rick_and_morty_app/src/data/models/models.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.type,
    required super.image,
    required super.gender,
  });

  factory CharacterModel.fromMap(Map<String, dynamic> data) {
    return CharacterModel(
      id: data['id'] as int? ?? 0,
      name: data['name'] as String? ?? '',
      status: CharacterStatusModel.fromServer(data['status'] as String? ?? '')
          .toEntity(),
      type: data['type'] as String? ?? '',
      image: data['image'] as String? ?? '',
      gender: GenderTypeModel.fromServer(data['gender'] as String? ?? '')
          .toEntity(),
    );
  }

  CharacterModel toEntity() {
    return CharacterModel(
      id: super.id,
      name: super.name,
      status: super.status,
      type: super.type,
      image: super.image,
      gender: super.gender,
    );
  }
}
