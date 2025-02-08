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
}
