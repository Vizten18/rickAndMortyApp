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

  factory CharacterModel.fromEntity(Character entity) {
    return CharacterModel(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      type: entity.type,
      image: entity.image,
      gender: entity.gender,
    );
  }

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

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      type: type,
      image: image,
      gender: gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': CharacterStatusModel.values
          .firstWhere((e) => e.toEntity() == status)
          .value,
      'type': type,
      'image': image,
    };
  }
}
