import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/interfaces/use_case.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/repositories/repositories.dart';

class GetFavorites
    extends UseCaseWithoutParams<Result<List<Character>, CharacterError>> {
  GetFavorites({
    required ICharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final ICharacterRepository _characterRepository;

  Stream<Character> get characters => _characterRepository.characters;
  Stream<int> get dislikedCharacters => _characterRepository.dislikedCharacters;

  @override
  Future<Result<List<Character>, CharacterError>> execute() async {
    return _characterRepository.getFavoriteCharacters();
  }
}
