import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';

class MockCharacterRepository extends Mock implements ICharacterRepository {}

void main() {
  late GetCharacterById useCase;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    useCase = GetCharacterById(characterRepository: mockCharacterRepository);
  });

  const character = Character.empty();

  test('should return a [Success] when the character is found', () async {
    when(() => mockCharacterRepository.getCharacterById(id: any(named: 'id')))
        .thenAnswer((_) async => Success(character));

    final result = await useCase.execute(1);

    expect(result, isA<Success<Character, CharacterError>>());
    final success = result as Success<Character, CharacterError>;
    expect(success.data?.id, 0);
    expect(success.data?.name, '');
  });

  test('should return a [Failure] when the character is not found', () async {
    when(() => mockCharacterRepository.getCharacterById(id: any(named: 'id')))
        .thenAnswer((_) async => Failure(CharacterErrorType.notFound));

    final result = await useCase.execute(1);

    expect(result, isA<Failure<Character, CharacterError>>());
    final failure = result as Failure<Character, CharacterError>;
    expect(failure.error, CharacterErrorType.notFound);
  });
}
