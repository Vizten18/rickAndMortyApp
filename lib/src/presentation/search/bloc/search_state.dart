// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum ModalFilterStatus {
  show,
  hide;

  bool get isShow => this == ModalFilterStatus.show;
  bool get isHide => this == ModalFilterStatus.hide;
}

enum SearchStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == SearchStatus.initial;
  bool get isLoading => this == SearchStatus.loading;
  bool get isSuccess => this == SearchStatus.success;
  bool get isFailure => this == SearchStatus.failure;
}

/// {@template search_state}
/// SearchState description
/// {@endtemplate}
class SearchState extends Equatable {
  /// {@macro search_state}
  SearchState({
    this.status = SearchStatus.initial,
    this.paginationStatus = SearchStatus.initial,
    this.modalFilterStatus = ModalFilterStatus.hide,
    List<CharacterStatus>? characterStatus,
    List<GenderType>? genderTypes,
    this.genderSelected = GenderType.none,
    this.statusSelected = CharacterStatus.none,
    this.searchText = '',
    this.characters = const <Character>[],
    this.pageInfo,
    this.error,
    this.currentPage = 1,
  })  : characterStatus = characterStatus ?? CharacterStatus.values,
        genderTypes = genderTypes ?? GenderType.valuesList;

  /// Status of the state
  final SearchStatus status;
  final SearchStatus paginationStatus;
  final ModalFilterStatus modalFilterStatus;
  final List<CharacterStatus>? characterStatus;
  final List<GenderType>? genderTypes;
  final CharacterStatus statusSelected;
  final GenderType genderSelected;
  final String searchText;
  final List<Character> characters;
  final PageInfo? pageInfo;
  final int currentPage;
  final CharacterError? error;

  @override
  List<Object?> get props => [
        status,
        paginationStatus,
        modalFilterStatus,
        characterStatus,
        genderTypes,
        genderSelected,
        statusSelected,
        searchText,
        characters,
        pageInfo,
        error,
        currentPage,
      ];

  /// Creates a copy of the current SearchState with property changes
  SearchState copyWith({
    SearchStatus? status,
    SearchStatus? paginationStatus,
    ModalFilterStatus? modalFilterStatus,
    List<CharacterStatus>? characterStatus,
    List<GenderType>? genderTypes,
    CharacterStatus? statusSelected,
    GenderType? genderSelected,
    String? searchText,
    List<Character>? characters,
    PageInfo? pageInfo,
    int? currentPage,
    CharacterError? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      paginationStatus: paginationStatus ?? this.paginationStatus,
      modalFilterStatus: modalFilterStatus ?? this.modalFilterStatus,
      characterStatus: characterStatus ?? this.characterStatus,
      genderTypes: genderTypes ?? this.genderTypes,
      statusSelected: statusSelected ?? this.statusSelected,
      genderSelected: genderSelected ?? this.genderSelected,
      searchText: searchText ?? this.searchText,
      characters: characters ?? this.characters,
      pageInfo: pageInfo ?? this.pageInfo,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
    );
  }

  SearchParameters get searchParameters => SearchParameters(
        name: searchText,
        status: statusSelected,
        gender: genderSelected,
        page: currentPage,
      );

  bool canPaginate(ScrollNotification scrollInfo) =>
      scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
      !paginationStatus.isLoading &&
      pageInfo?.nextPage != null;
}
