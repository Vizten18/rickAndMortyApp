import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/interfaces/use_case.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/repositories/character_repository.dart';

class GetCharacterById
    extends UseCaseWithParams<Result<Character, CharacterError>, int> {
  GetCharacterById({
    required ICharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final ICharacterRepository _characterRepository;

  @override
  Future<Result<Character, CharacterError>> execute(
    int parameters,
  ) async {
    return _characterRepository.getCharacterById(id: parameters);
  }
}
