// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

enum FavoritesStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == FavoritesStatus.initial;
  bool get isLoading => this == FavoritesStatus.loading;
  bool get isSuccess => this == FavoritesStatus.success;
  bool get isFailure => this == FavoritesStatus.failure;
}

/// {@template favorites_state}
/// FavoritesState description
/// {@endtemplate}
class FavoritesState extends Equatable {
  /// {@macro favorites_state}
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.characters = const [],
  });

  /// Status of the state
  final FavoritesStatus status;
  final List<Character> characters;

  @override
  List<Object> get props => [
        status,
        characters,
      ];

  /// Creates a copy of the current FavoritesState with property changes
  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Character>? characters,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
    );
  }
}
