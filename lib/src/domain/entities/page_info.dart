// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PageInfo extends Equatable {
  final String nextPage;
  final String prevPage;
  const PageInfo({
    required this.nextPage,
    required this.prevPage,
  });

  @override
  List<Object?> get props => [
        nextPage,
        prevPage,
      ];

  const PageInfo.empty()
      : nextPage = '',
        prevPage = '';
}
