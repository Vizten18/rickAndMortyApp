import 'dart:developer';

import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/src/data/data_sources/data_sources.dart';
import 'package:rick_and_morty_app/src/domain/entities/character.dart';
import 'package:rick_and_morty_app/src/domain/entities/paginated_data.dart';
import 'package:rick_and_morty_app/src/domain/repositories/repositories.dart';

class CharacterRepository extends ICharacterRepository {
  CharacterRepository({
    required ICharacterApi characterApi,
  }) : _characterApi = characterApi;

  final ICharacterApi _characterApi;
  final String source = 'CharacterRepository';
  @override
  Future<Result<Character, CharacterError>> getCharacterById({
    required int id,
  }) async {
    log('📡 Trying to get character by id', name: '$source.getCharacterById');
    return _characterApi.getCharacterById(id: id);
  }

  @override
  Future<Result<PaginatedData<Character>, CharacterError>> getCharacters({
    required int page,
  }) async {
    log('📡 Trying to get characters', name: '$source.getCharacters');
    return _characterApi.getCharacters(page: page);
  }
}
