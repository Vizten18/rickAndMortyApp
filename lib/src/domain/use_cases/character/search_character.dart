import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/interfaces/use_case.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/repositories/repositories.dart';

class SearchCharacter extends UseCaseWithParams<
    Result<PaginatedData<Character>, CharacterError>, SearchParameters> {
  SearchCharacter({
    required ICharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  final ICharacterRepository _characterRepository;
  @override
  Future<Result<PaginatedData<Character>, CharacterError>> execute(
    SearchParameters parameters,
  ) {
    return _characterRepository.searchCharacters(
      searchParameters: parameters,
    );
  }
}
