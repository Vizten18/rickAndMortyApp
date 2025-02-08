import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesApi {
  static const String likedCharactersKey = 'likedCharacters';

  Future<List<String>> getLikedCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(likedCharactersKey) ?? [];
  }

  Future<Result<void, CharacterError>> likeCharacter(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final likedCharacters = prefs.getStringList(likedCharactersKey) ?? [];
      if (!likedCharacters.contains(id.toString())) {
        likedCharacters.add(id.toString());
        await prefs.setStringList(likedCharactersKey, likedCharacters);
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
      if (likedCharacters.contains(id.toString())) {
        likedCharacters.remove(id.toString());
        await prefs.setStringList(likedCharactersKey, likedCharacters);
      }
      return Success(null);
    } catch (e) {
      return Failure(CharacterErrorType.unknown);
    }
  }

  Future<bool> isCharacterLiked(int id) async {
    final likedCharacters = await getLikedCharacters();
    return likedCharacters.contains(id.toString());
  }
}
