import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class SearchParametersModel extends SearchParameters {
  const SearchParametersModel({
    super.name,
    super.status,
    super.gender,
    super.page,
  });

  factory SearchParametersModel.fromEntity(SearchParameters searchParameters) {
    return SearchParametersModel(
      name: searchParameters.name,
      status: searchParameters.status,
      gender: searchParameters.gender,
      page: searchParameters.page,
    );
  }

  factory SearchParametersModel.empty() {
    return const SearchParametersModel(
      name: '',
      status: CharacterStatus.none,
      gender: GenderType.none,
    );
  }

  Map<String, String> toQueryParameters() {
    final queryParams = <String, String>{};

    if (page != null) {
      queryParams['page'] = page.toString();
    }

    if (name != null && name!.isNotEmpty) {
      queryParams['name'] = name!;
    }
    if (status != null && status != CharacterStatus.none) {
      queryParams['status'] = status!.name.toLowerCase();
    }
    if (gender != null && gender != GenderType.none) {
      queryParams['gender'] = gender!.name.toLowerCase();
    }

    return queryParams;
  }
}
