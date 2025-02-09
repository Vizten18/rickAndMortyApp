import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';

class MockCharacterRepository extends Mock implements ICharacterRepository {}

void main() {
  late GetCharacters useCase;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    useCase = GetCharacters(characterRepository: mockCharacterRepository);
  });

  const character = Character.empty();
  const paginatedData = PaginatedData<Character>(
    pageInfo: PageInfo.empty(),
    items: [character],
  );

  test('should return a [Success] when characters are found', () async {
    when(() => mockCharacterRepository.getCharacters(page: any(named: 'page')))
        .thenAnswer((_) async => Success(paginatedData));

    final result = await useCase.execute(1);

    expect(result, isA<Success<PaginatedData<Character>, CharacterError>>());
    final success = result as Success<PaginatedData<Character>, CharacterError>;
    expect(success.data?.items.length, 1);
    expect(success.data?.items.first.name, '');
  });

  test('should return a [Failure] when characters are not found', () async {
    when(() => mockCharacterRepository.getCharacters(page: any(named: 'page')))
        .thenAnswer((_) async => Failure(CharacterErrorType.notFound));

    final result = await useCase.execute(1);

    expect(result, isA<Failure<PaginatedData<Character>, CharacterError>>());
    final failure = result as Failure<PaginatedData<Character>, CharacterError>;
    expect(failure.error, CharacterErrorType.notFound);
  });
}
