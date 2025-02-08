// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class PaginatedData<T> extends Equatable {
  /// A desciption for pageInfo
  final PageInfo pageInfo;

  /// A description for items
  final List<T> items;

  const PaginatedData({
    required this.pageInfo,
    required this.items,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        pageInfo,
        items,
      ];
}
