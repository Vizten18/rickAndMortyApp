import 'dart:async';
import 'dart:developer';

import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/src/data/data_sources/data_sources.dart';
import 'package:rick_and_morty_app/src/data/models/models.dart';
import 'package:rick_and_morty_app/src/domain/entities/character.dart';
import 'package:rick_and_morty_app/src/domain/entities/paginated_data.dart';
import 'package:rick_and_morty_app/src/domain/entities/search_parameters.dart';
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

  // Streams
  final _likeCharacterStreamController =
      StreamController<Character>.broadcast();
  final _dislikeCharacterStreamController = StreamController<int>.broadcast();

  @override
  Stream<Character> get characters => _likeCharacterStreamController.stream;

  @override
  Stream<int> get dislikedCharacters =>
      _dislikeCharacterStreamController.stream;

  void Function(Character) get _likeCharactersSink =>
      _likeCharacterStreamController.sink.add;
  void Function(int) get _dislikeCharactersSink =>
      _dislikeCharacterStreamController.sink.add;

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
    required Character character,
  }) async {
    log('📡 Trying to like character', name: '$source.likeCharacter');
    _likeCharactersSink(character);
    return _sharedPreferencesApi.likeCharacter(character);
  }

  @override
  Future<Result<void, CharacterError>> unlikeCharacter({
    required int id,
  }) async {
    log('📡 Trying to unlike character', name: '$source.unlikeCharacter');
    final result = await _sharedPreferencesApi.unlikeCharacter(id);
    if (result is Success) {
      _dislikeCharactersSink(id);
    }
    return result;
  }

  @override
  Future<Result<List<Character>, CharacterError>> getLikedCharacters() async {
    log(
      '📡 Trying to get liked characters',
      name: '$source.getLikedCharacters',
    );
    final likedCharacters = await _sharedPreferencesApi.getLikedCharacters();
    return Success(likedCharacters);
  }

  @override
  Future<Result<List<Character>, CharacterError>>
      getFavoriteCharacters() async {
    log(
      '📡 Trying to get favorite characters',
      name: '$source.getFavoriteCharacters',
    );
    final likedCharacters = await _sharedPreferencesApi.getLikedCharacters();
    return Success(likedCharacters);
  }

  @override
  Future<Result<PaginatedData<Character>, CharacterError>> searchCharacters({
    required SearchParameters searchParameters,
  }) async {
    log('📡 Trying to search characters', name: '$source.searchCharacters');
    return _characterApi.searchCharacters(
      searchParametersModel: SearchParametersModel.fromEntity(searchParameters),
    );
  }
}
