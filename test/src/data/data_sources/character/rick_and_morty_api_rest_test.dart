import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/helpers/http/custom_dio_client.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/typedefs/type_defs.dart';
import 'package:rick_and_morty_app/src/data/data_sources/character/rick_and_morty_api_rest.dart';
import 'package:rick_and_morty_app/src/data/models/character_model.dart';
import 'package:rick_and_morty_app/src/data/models/paginated_data_model.dart';
import 'package:rick_and_morty_app/src/data/models/search_parameters_model.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DioClient dioClient;
  late RickAndMortyApiRest api;

  setUp(() {
    dioClient = MockDioClient();
    api = RickAndMortyApiRest(dioClient: dioClient);
  });

  final dataResponse = {
    'id': 1,
    'name': 'Rick Sanchez',
    'status': 'Alive',
    'type': '',
  };

  group('RickAndMortyApiRest.getCharacterById', () {
    test('should return a [Success] when the character is found', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: dataResponse,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await api.getCharacterById(id: 1);

      expect(result, isA<Success<CharacterModel, CharacterError>>());
      final success = result as Success<CharacterModel, CharacterError>;
      expect(success.data?.id, 1);
      expect(success.data?.name, 'Rick Sanchez');
    });

    test('should return a [Failure] when the character is not found', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await api.getCharacterById(id: 1);

      expect(result, isA<Failure<CharacterModel, CharacterError>>());
      final failure = result as Failure<CharacterModel, CharacterError>;
      expect(failure.error, CharacterErrorType.notFound);
    });

    test('should return a [Failure] on DioException', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await api.getCharacterById(id: 1);

      expect(result, isA<Failure<CharacterModel, CharacterError>>());
      final failure = result as Failure<CharacterModel, CharacterError>;
      expect(failure.error, CharacterErrorType.network);
    });
  });

  group('RickAndMortyApiRest.getCharacters', () {
    final paginatedDataResponse = {
      'info': {
        'count': 1,
        'pages': 1,
        'next': null,
        'prev': null,
      },
      'results': [
        {
          'id': 1,
          'name': 'Rick Sanchez',
          'status': 'Alive',
          'type': '',
        },
      ],
    };

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('should return a [Success] when characters are found', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: paginatedDataResponse,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await api.getCharacters(page: 1);

      expect(
        result,
        isA<Success<PaginatedDataModel<CharacterModel>, CharacterError>>(),
      );
      final success =
          result as Success<PaginatedDataModel<CharacterModel>, CharacterError>;
      expect(success.data?.items.length, 1);
      expect(success.data?.items.first.name, 'Rick Sanchez');
    });

    test('should return a [Failure] when characters are not found', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await api.getCharacters(page: 1);

      expect(
        result,
        isA<Failure<PaginatedDataModel<CharacterModel>, CharacterError>>(),
      );
      final failure =
          result as Failure<PaginatedDataModel<CharacterModel>, CharacterError>;
      expect(failure.error, CharacterErrorType.notFound);
    });

    test('should return a [Failure] on DioException', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await api.getCharacters(page: 1);

      expect(
        result,
        isA<Failure<PaginatedDataModel<CharacterModel>, CharacterError>>(),
      );
      final failure =
          result as Failure<PaginatedDataModel<CharacterModel>, CharacterError>;
      expect(failure.error, CharacterErrorType.network);
    });
  });

  group('RickAndMortyApiRest.searchCharacters', () {
    final searchParameters = SearchParametersModel.empty();

    final paginatedDataResponse = {
      'info': {
        'count': 1,
        'pages': 1,
        'next': null,
        'prev': null,
      },
      'results': [
        {
          'id': 1,
          'name': 'Rick Sanchez',
          'status': 'Alive',
          'type': '',
        },
      ],
    };

    test('should return a [Success] when characters are found', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: paginatedDataResponse,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result =
          await api.searchCharacters(searchParametersModel: searchParameters);

      expect(
        result,
        isA<Success<PaginatedDataModel<CharacterModel>, CharacterError>>(),
      );
      final success =
          result as Success<PaginatedDataModel<CharacterModel>, CharacterError>;
      expect(success.data?.items.length, 1);
      expect(success.data?.items.first.name, 'Rick Sanchez');
    });

    test('should return a [Failure] when characters are not found', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
      );

      final result =
          await api.searchCharacters(searchParametersModel: searchParameters);

      expect(
        result,
        isA<Failure<PaginatedDataModel<CharacterModel>, CharacterError>>(),
      );
      final failure =
          result as Failure<PaginatedDataModel<CharacterModel>, CharacterError>;
      expect(failure.error, CharacterErrorType.notFound);
    });

    test('should return a [Failure] on DioException', () async {
      when(
        () => dioClient.get<DataMap>(
          any(),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result =
          await api.searchCharacters(searchParametersModel: searchParameters);

      expect(
        result,
        isA<Failure<PaginatedDataModel<CharacterModel>, CharacterError>>(),
      );
      final failure =
          result as Failure<PaginatedDataModel<CharacterModel>, CharacterError>;
      expect(failure.error, CharacterErrorType.network);
    });
  });
}
