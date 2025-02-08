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
    required SharedPreferencesApi sharedPreferencesApi,
  })  : _characterApi = characterApi,
        _sharedPreferencesApi = sharedPreferencesApi;

  final ICharacterApi _characterApi;
  final SharedPreferencesApi _sharedPreferencesApi;
  final String source = 'CharacterRepository';

  @override
  Future<Result<Character, CharacterError>> getCharacterById({
    required int id,
  }) async {
    log('📡 Trying to get character by id', name: '$source.getCharacterById');
    final result = await _characterApi.getCharacterById(id: id);
    if (result is Success) {
      final isLiked = await _sharedPreferencesApi.isCharacterLiked(id);
      final character = result.data?.copyWith(liked: isLiked);
      return Success(
        character ?? const Character.empty(),
      );
    }
    return result;
  }

  @override
  Future<Result<PaginatedData<Character>, CharacterError>> getCharacters({
    required int page,
  }) async {
    log('📡 Trying to get characters', name: '$source.getCharacters');
    return _characterApi.getCharacters(page: page);
  }

  @override
  Future<Result<void, CharacterError>> likeCharacter({
    required int id,
  }) async {
    log('📡 Trying to like character', name: '$source.likeCharacter');
    return _sharedPreferencesApi.likeCharacter(id);
  }

  @override
  Future<Result<void, CharacterError>> unlikeCharacter({
    required int id,
  }) async {
    log('📡 Trying to unlike character', name: '$source.unlikeCharacter');
    return _sharedPreferencesApi.unlikeCharacter(id);
  }
}
