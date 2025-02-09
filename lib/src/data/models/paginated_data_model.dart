import 'package:rick_and_morty_app/src/data/models/models.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class PaginatedDataModel<T> extends PaginatedData<T> {
  const PaginatedDataModel({
    required super.pageInfo,
    required super.items,
  });

  factory PaginatedDataModel.fromJson(
    Map<String, dynamic> data,
    T Function(Map<String, dynamic> data) fromJson,
  ) {
    return PaginatedDataModel(
      pageInfo: PageInfoModel.fromJson(data['info'] as Map<String, dynamic>),
      items: (data['results'] as List<dynamic>? ?? [])
          .nonNulls
          .toList()
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T) toJson) {
    return {
      'info': (pageInfo as PageInfoModel).toMap(),
      'results': items.map((e) => toJson(e)).toList(),
    };
  }
}
