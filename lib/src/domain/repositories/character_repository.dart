// ignore_for_file: one_member_abstracts

import 'package:rick_and_morty_app/core/errors/base_error.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

abstract class ICharacterRepository {
  /// Fetches a list of characters.
  /// return a [PaginatedData<Character>] on success
  /// or a [BaseError] on failure.
  Future<Result<PaginatedData<Character>, CharacterError>> getCharacters({
    required int page,
  });

  /// Fetches a character by its [id].
  /// return a [Character] on success
  /// or a [BaseError] on failure.
  Future<Result<Character, CharacterError>> getCharacterById({
    required int id,
  });

  /// Likes a character by its [id].
  /// return a [Result<void, CharacterError>] on success or failure.
  Future<Result<void, CharacterError>> likeCharacter({required int id});

  /// Unlikes a character by its [id].
  /// return a [Result<void, CharacterError>] on success or failure.
  Future<Result<void, CharacterError>> unlikeCharacter({
    required int id,
  });
}
