// ignore_for_file: comment_references

import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/src/data/models/models.dart';

abstract class ICharacterApi {
  /// Fetches a list of characters.
  /// return a [PaginatedData<Character>] on success
  /// or a [BaseError] on failure.
  Future<Result<PaginatedDataModel<CharacterModel>, CharacterError>>
      getCharacters({
    required int page,
  });

  /// Fetches a character by its [id].
  /// return a [Character] on success
  /// or a [BaseError] on failure.
  Future<Result<CharacterModel, CharacterError>> getCharacterById({
    required int id,
  });
}
