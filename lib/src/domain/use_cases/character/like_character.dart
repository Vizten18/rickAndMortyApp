import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/interfaces/use_case.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/repositories/repositories.dart';

class LikeCharacter
    extends UseCaseWithParams<Result<void, CharacterError>, Character> {
  LikeCharacter({
    required ICharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final ICharacterRepository _characterRepository;
  @override
  Future<Result<void, CharacterError>> execute(Character parameters) async {
    return _characterRepository.likeCharacter(character: parameters);
  }
}
