import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/helpers/http/custom_dio_client.dart';
import 'package:rick_and_morty_app/core/interfaces/result.dart';
import 'package:rick_and_morty_app/core/typedefs/type_defs.dart';
import 'package:rick_and_morty_app/src/data/data_sources/data_sources.dart';
import 'package:rick_and_morty_app/src/data/models/character_model.dart';
import 'package:rick_and_morty_app/src/data/models/paginated_data_model.dart';

class RickAndMortyApiRest extends ICharacterApi {
  RickAndMortyApiRest()
      : _dioClient = DioClient(
          baseUrl: RickAndMortyEndpoints.baseUrl,
          headers: {
            'Content-Type': 'application/json',
          },
        );
  final DioClient _dioClient;
  final String source = 'RickAndMortyApiRest';

  @override
  Future<Result<CharacterModel, CharacterError>> getCharacterById({
    required int id,
  }) async {
    try {
      final response = await _dioClient.get<DataMap>(
        RickAndMortyEndpoints.getCharacterById(id: id),
      );
      switch (response.statusCode) {
        case 404:
          log('❌ Character not found: $id', name: '$source.getCharacterById');
          return Failure(CharacterErrorType.notFound);
        case 200:
          final character = CharacterModel.fromMap(
            response.data!,
          );
          log(
            '✅ Character fetched successfully: $id',
            name: '$source.getCharacterById',
          );
          return Success(character);
        default:
          log(
            '❌ Unknown error for character: $id',
            name: '$source.getCharacterById',
          );
          return Failure(CharacterErrorType.unknown);
      }
    } on DioException catch (e) {
      log(
        '❌ DioException for character: $id, ${e.message}',
        name: '$source.getCharacterById',
      );
      return Failure(e.characterErrorType);
    } catch (e) {
      log(
        '❌ Unknown exception for character: $id, $e',
        name: '$source.getCharacterById',
      );
      return Failure(CharacterErrorType.unknown);
    }
  }

  @override
  Future<Result<PaginatedDataModel<CharacterModel>, CharacterError>>
      getCharacters({
    required int page,
  }) async {
    try {
      final response = await _dioClient.get<DataMap>(
        RickAndMortyEndpoints.getCharacters(page: page),
      );

      final data = response.data!;
      switch (response.statusCode) {
        case 200:
          final paginatedData = PaginatedDataModel<CharacterModel>.fromJson(
            data,
            CharacterModel.fromMap,
          );
          log(
            '✅ Characters fetched successfully for page: $page',
            name: '$source.getCharacters',
          );
          return Success(paginatedData);
        default:
          log(
            '❌ Unknown error for characters on page: $page',
            name: '$source.getCharacters',
          );
          return Failure(CharacterErrorType.unknown);
      }
    } on DioException catch (e) {
      log(
        '❌ DioException for characters on page: $page, ${e.message}',
        name: '$source.getCharacters',
      );
      return Failure(e.characterErrorType);
    } catch (e) {
      log(
        '❌ Unknown exception for characters on page: $page, $e',
        name: '$source.getCharacters',
      );
      return Failure(CharacterErrorType.unknown);
    }
  }
}
