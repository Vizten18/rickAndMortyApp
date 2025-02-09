import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class PageInfoModel extends PageInfo {
  const PageInfoModel({
    required super.nextPage,
    required super.prevPage,
  });
  const PageInfoModel.empty() : super(nextPage: '', prevPage: '');

  factory PageInfoModel.fromJson(Map<String, dynamic> data) {
    return PageInfoModel(
      nextPage: data['next'] as String? ?? '',
      prevPage: data['prev'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'next': nextPage,
      'prev': prevPage,
    };
  }
}
