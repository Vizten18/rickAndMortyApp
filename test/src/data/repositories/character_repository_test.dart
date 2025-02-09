import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/src/data/data_sources/data_sources.dart';
import 'package:rick_and_morty_app/src/data/models/models.dart';
import 'package:rick_and_morty_app/src/data/repositories/character_repository.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class MockCharacterApi extends Mock implements ICharacterApi {}

class MockSharedPreferencesApi extends Mock implements SharedPreferencesApi {}

class FakeSearchParametersModel extends Fake implements SearchParametersModel {}

class FakeCharacter extends Fake implements Character {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeSearchParametersModel());
    registerFallbackValue(FakeCharacter());
  });

  late CharacterRepository repository;
  late MockCharacterApi mockCharacterApi;
  late MockSharedPreferencesApi mockSharedPreferencesApi;

  setUp(() {
    mockCharacterApi = MockCharacterApi();
    mockSharedPreferencesApi = MockSharedPreferencesApi();
    repository = CharacterRepository(
      characterApi: mockCharacterApi,
      sharedPreferencesApi: mockSharedPreferencesApi,
    );
  });

  final characterModel = CharacterModel.empty();
  final character = characterModel.toEntity();

  final paginatedDataModel = PaginatedDataModel<CharacterModel>(
    pageInfo: const PageInfoModel.empty(),
    items: [characterModel],
  );

  group('CharacterRepository.getCharacterById', () {
    test('should return a [Success] when the character is found', () async {
      when(() => mockCharacterApi.getCharacterById(id: any(named: 'id')))
          .thenAnswer((_) async => Success(characterModel));

      when(() => mockSharedPreferencesApi.isCharacterLiked(any()))
          .thenAnswer((_) async => true);

      final result = await repository.getCharacterById(id: 1);

      expect(result, isA<Success<Character, CharacterError>>());
      final success = result as Success<Character, CharacterError>;
      expect(success.data?.id, 0);
      expect(success.data?.liked, true);
    });

    test('should return a [Failure] when the character is not found', () async {
      when(() => mockCharacterApi.getCharacterById(id: any(named: 'id')))
          .thenAnswer((_) async => Failure(CharacterErrorType.notFound));

      final result = await repository.getCharacterById(id: 1);

      expect(result, isA<Failure<Character, CharacterError>>());
      final failure = result as Failure<Character, CharacterError>;
      expect(failure.error, CharacterErrorType.notFound);
    });
  });

  group('CharacterRepository.getCharacters', () {
    test('should return a [Success] when characters are found', () async {
      when(() => mockCharacterApi.getCharacters(page: any(named: 'page')))
          .thenAnswer((_) async => Success(paginatedDataModel));

      final result = await repository.getCharacters(page: 1);

      expect(result, isA<Success<PaginatedData<Character>, CharacterError>>());
      final success =
          result as Success<PaginatedData<Character>, CharacterError>;
      expect(success.data?.items.length, 1);
      expect(success.data?.items.first.name, '');
    });

    test('should return a [Failure] when characters are not found', () async {
      when(() => mockCharacterApi.getCharacters(page: any(named: 'page')))
          .thenAnswer((_) async => Failure(CharacterErrorType.notFound));

      final result = await repository.getCharacters(page: 1);

      expect(result, isA<Failure<PaginatedData<Character>, CharacterError>>());
      final failure =
          result as Failure<PaginatedData<Character>, CharacterError>;
      expect(failure.error, CharacterErrorType.notFound);
    });
  });

  group('CharacterRepository.searchCharacters', () {
    const searchParameters = SearchParameters.empty();

    test('should return a [Success] when characters are found', () async {
      when(
        () => mockCharacterApi.searchCharacters(
          searchParametersModel: any(named: 'searchParametersModel'),
        ),
      ).thenAnswer((_) async => Success(paginatedDataModel));

      final result =
          await repository.searchCharacters(searchParameters: searchParameters);

      expect(result, isA<Success<PaginatedData<Character>, CharacterError>>());
      final success =
          result as Success<PaginatedData<Character>, CharacterError>;
      expect(success.data?.items.length, 1);
      expect(success.data?.items.first.name, '');
    });

    test('should return a [Failure] when characters are not found', () async {
      when(
        () => mockCharacterApi.searchCharacters(
          searchParametersModel: any(named: 'searchParametersModel'),
        ),
      ).thenAnswer((_) async => Failure(CharacterErrorType.notFound));

      final result =
          await repository.searchCharacters(searchParameters: searchParameters);

      expect(result, isA<Failure<PaginatedData<Character>, CharacterError>>());
      final failure =
          result as Failure<PaginatedData<Character>, CharacterError>;
      expect(failure.error, CharacterErrorType.notFound);
    });
  });

  group('CharacterRepository.likeCharacter', () {
    test('should like a character successfully', () async {
      when(() => mockSharedPreferencesApi.likeCharacter(any()))
          .thenAnswer((_) async => Success(null));

      final result = await repository.likeCharacter(character: character);

      expect(result, isA<Success<void, CharacterError>>());
      verify(() => mockSharedPreferencesApi.likeCharacter(character)).called(1);
    });

    test('should return a [Failure] when liking a character fails', () async {
      when(() => mockSharedPreferencesApi.likeCharacter(any()))
          .thenAnswer((_) async => Failure(CharacterErrorType.unknown));

      final result = await repository.likeCharacter(character: character);

      expect(result, isA<Failure<void, CharacterError>>());
      final failure = result as Failure<void, CharacterError>;
      expect(failure.error, CharacterErrorType.unknown);
    });
  });

  group('CharacterRepository.unlikeCharacter', () {
    test('should unlike a character successfully', () async {
      when(() => mockSharedPreferencesApi.unlikeCharacter(any()))
          .thenAnswer((_) async => Success(null));

      final result = await repository.unlikeCharacter(id: 1);

      expect(result, isA<Success<void, CharacterError>>());
      verify(() => mockSharedPreferencesApi.unlikeCharacter(1)).called(1);
    });

    test('should return a [Failure] when unliking a character fails', () async {
      when(() => mockSharedPreferencesApi.unlikeCharacter(any()))
          .thenAnswer((_) async => Failure(CharacterErrorType.unknown));

      final result = await repository.unlikeCharacter(id: 1);

      expect(result, isA<Failure<void, CharacterError>>());
      final failure = result as Failure<void, CharacterError>;
      expect(failure.error, CharacterErrorType.unknown);
    });
  });

  group('CharacterRepository.getLikedCharacters', () {
    test('should return liked characters successfully', () async {
      when(() => mockSharedPreferencesApi.getLikedCharacters())
          .thenAnswer((_) async => [character]);

      final result = await repository.getLikedCharacters();

      expect(result, isA<Success<List<Character>, CharacterError>>());
      final success = result as Success<List<Character>, CharacterError>;
      expect(success.data?.length, 1);
      expect(success.data?.first.name, '');
    });
  });

  group('CharacterRepository.getFavoriteCharacters', () {
    test('should return favorite characters successfully', () async {
      when(() => mockSharedPreferencesApi.getLikedCharacters())
          .thenAnswer((_) async => [character]);

      final result = await repository.getFavoriteCharacters();

      expect(result, isA<Success<List<Character>, CharacterError>>());
      final success = result as Success<List<Character>, CharacterError>;
      expect(success.data?.length, 1);
      expect(success.data?.first.name, '');
    });
  });
}
