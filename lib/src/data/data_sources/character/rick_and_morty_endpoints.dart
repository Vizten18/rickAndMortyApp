import 'package:rick_and_morty_app/src/data/models/search_parameters_model.dart';

class RickAndMortyEndpoints {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  static String getCharacters({
    int? page,
  }) =>
      '$baseUrl/character?page=$page';

  static String getCharacterById({
    required int id,
  }) =>
      '$baseUrl/character/$id';

  static String searchCharacters({
    required SearchParametersModel searchParametersModel,
  }) {
    final queryParams = searchParametersModel.toQueryParameters();

    final queryString = queryParams.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

    return '$baseUrl/character/?$queryString';
  }
}
