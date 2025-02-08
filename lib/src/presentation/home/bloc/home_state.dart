// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

/// {@template home_state}
/// HomeState description
/// {@endtemplate}
class HomeState extends Equatable {
  /// {@macro home_state}
  const HomeState({
    this.status = HomeStatus.initial,
    this.characters = const <Character>[],
    this.pageInfo,
    this.currentPage = 1,
  });

  /// Status of the state
  final HomeStatus status;
  final List<Character> characters;
  final PageInfo? pageInfo;
  final int currentPage;

  @override
  List<Object?> get props => [
        status,
        characters,
        pageInfo,
        currentPage,
      ];

  /// Creates a copy of the current HomeState with property changes
  HomeState copyWith({
    HomeStatus? status,
    List<Character>? characters,
    PageInfo? pageInfo,
    int? currentPage,
  }) {
    return HomeState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      pageInfo: pageInfo ?? this.pageInfo,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
