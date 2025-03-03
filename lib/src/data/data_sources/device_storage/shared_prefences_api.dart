import 'dart:convert';

import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/typedefs/data_map.dart';
import 'package:rick_and_morty_app/src/data/models/models.dart';
import 'package:rick_and_morty_app/src/domain/entities/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApi {
  static const String likedCharactersKey = 'likedCharacters';
  static const String likedCharactersListKey = 'likedCharactersList';
  static const String cachedCharactersPage1Key = 'cachedCharactersPage1';

  Future<List<int>> getLikedCharacterIds() async {
    final prefs = await SharedPreferences.getInstance();
    final likedCharacters = prefs.getStringList(likedCharactersKey) ?? [];
    return likedCharacters.map(int.parse).toList();
  }

  Future<List<Character>> getLikedCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    final likedCharactersJson =
        prefs.getStringList(likedCharactersListKey) ?? [];
    return likedCharactersJson
        .map(
          (json) =>
              CharacterModel.fromMap(jsonDecode(json) as DataMap).toEntity(),
        )
        .toList();
  }

  Future<Result<void, CharacterError>> likeCharacter(
    Character character,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likedCharacters = prefs.getStringList(likedCharactersKey) ?? [];
      final likedCharactersList =
          prefs.getStringList(likedCharactersListKey) ?? [];

      if (!likedCharacters.contains(character.id.toString())) {
        likedCharacters.add(character.id.toString());
        likedCharactersList
            .add(jsonEncode(CharacterModel.fromEntity(character).toMap()));
        await prefs.setStringList(likedCharactersKey, likedCharacters);
        await prefs.setStringList(likedCharactersListKey, likedCharactersList);
      }
      return Success(null);
    } catch (e) {
      return Failure(CharacterErrorType.unknown);
    }
  }

  Future<Result<void, CharacterError>> unlikeCharacter(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likedCharacters = prefs.getStringList(likedCharactersKey) ?? [];
      final likedCharactersList =
          prefs.getStringList(likedCharactersListKey) ?? [];

      if (likedCharacters.contains(id.toString())) {
        likedCharacters.remove(id.toString());
        likedCharactersList.removeWhere(
          (json) =>
              CharacterModel.fromMap(jsonDecode(json) as DataMap).id == id,
        );
        await prefs.setStringList(likedCharactersKey, likedCharacters);
        await prefs.setStringList(likedCharactersListKey, likedCharactersList);
      }
      return Success(null);
    } catch (e) {
      return Failure(CharacterErrorType.unknown);
    }
  }

  Future<bool> isCharacterLiked(int id) async {
    final likedCharacters = await getLikedCharacterIds();
    return likedCharacters.contains(id);
  }

  Future<void> cacheCharactersPage1(
    PaginatedDataModel<CharacterModel> data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(
      data.toMap(
        (character) => character.toMap(),
      ),
    );
    await prefs.setString(cachedCharactersPage1Key, jsonData);
  }

  Future<PaginatedDataModel<CharacterModel>?> getCachedCharactersPage1() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(cachedCharactersPage1Key);
    if (jsonData != null) {
      final dataMap = jsonDecode(jsonData) as DataMap;
      return PaginatedDataModel<CharacterModel>.fromJson(
        dataMap,
        CharacterModel.fromMap,
      );
    }
    return null;
  }
}
