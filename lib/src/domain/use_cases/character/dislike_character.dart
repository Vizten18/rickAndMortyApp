import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/interfaces/use_case.dart';
import 'package:rick_and_morty_app/src/domain/repositories/repositories.dart';

class DislikeCharacter
    extends UseCaseWithParams<Result<void, CharacterError>, int> {
  DislikeCharacter({
    required ICharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final ICharacterRepository _characterRepository;
  @override
  Future<Result<void, CharacterError>> execute(int parameters) async {
    return _characterRepository.unlikeCharacter(id: parameters);
  }
}
