// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_field_initializers_in_const_classes, lines_longer_than_80_chars
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class SearchParameters extends Equatable {
  const SearchParameters({
    this.name,
    this.status,
    this.gender,
    this.page = 1,
  });

  final String? name;
  final CharacterStatus? status;
  final GenderType? gender;
  final int? page;

  @override
  List<Object?> get props => [
        name,
        status,
        gender,
        page,
      ];

  SearchParameters copyWith({
    String? name,
    CharacterStatus? status,
    GenderType? gender,
    int? page,
  }) {
    return SearchParameters(
      name: name ?? this.name,
      status: status ?? this.status,
      gender: gender ?? this.gender,
      page: page ?? this.page,
    );
  }

  const SearchParameters.empty()
      : name = '',
        status = CharacterStatus.none,
        gender = GenderType.none,
        page = 1;
}
