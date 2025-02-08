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
    this.paginationStatus = HomeStatus.initial,
    this.characters = const <Character>[],
    this.pageInfo,
    this.currentPage = 1,
    this.error,
  });

  /// Status of the state
  final HomeStatus status;
  final HomeStatus paginationStatus;
  final List<Character> characters;
  final PageInfo? pageInfo;
  final int currentPage;
  final CharacterError? error;

  @override
  List<Object?> get props => [
        status,
        paginationStatus,
        characters,
        pageInfo,
        currentPage,
        error,
      ];

  /// Creates a copy of the current HomeState with property changes
  HomeState copyWith({
    HomeStatus? status,
    HomeStatus? paginationStatus,
    List<Character>? characters,
    PageInfo? pageInfo,
    int? currentPage,
    CharacterError? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      paginationStatus: paginationStatus ?? this.paginationStatus,
      characters: characters ?? this.characters,
      pageInfo: pageInfo ?? this.pageInfo,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
    );
  }

  bool canPaginate(ScrollNotification scrollInfo) =>
      scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
      !paginationStatus.isLoading &&
      pageInfo?.nextPage != null;
}
