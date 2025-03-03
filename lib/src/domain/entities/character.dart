// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final CharacterStatus status;
  final String type;
  final String image;
  final GenderType gender;
  final bool liked;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.type,
    required this.image,
    required this.gender,
    this.liked = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        type,
        image,
        gender,
        liked,
      ];

  const Character.empty()
      : id = 0,
        name = '',
        status = CharacterStatus.none,
        type = '',
        image = '',
        gender = GenderType.unknown,
        liked = false;

  Character copyWith({
    int? id,
    String? name,
    CharacterStatus? status,
    String? type,
    String? image,
    GenderType? gender,
    bool? liked,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      type: type ?? this.type,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      liked: liked ?? this.liked,
    );
  }
}
