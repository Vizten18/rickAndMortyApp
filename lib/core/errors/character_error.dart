// ignore_for_file: no_default_cases

import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/errors/base_error.dart';

sealed class CharacterError extends BaseError implements Exception {
  const CharacterError();

  CharacterErrorType get characterErrorType;
}

enum CharacterErrorType implements CharacterError {
  unknown,
  network,
  server,
  client,
  notFound;

  @override
  CharacterErrorType get characterErrorType => this;
}

extension CharacterErrorExtension on DioException {
  CharacterErrorType get characterErrorType {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return CharacterErrorType.network;
      case DioExceptionType.badResponse:
        return CharacterErrorType.server;
      case DioExceptionType.cancel:
        return CharacterErrorType.client;
      case DioExceptionType.unknown:
        return CharacterErrorType.unknown;
      default:
        return CharacterErrorType.unknown;
    }
  }
}
