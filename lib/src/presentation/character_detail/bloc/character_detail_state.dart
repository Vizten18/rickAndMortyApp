// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'character_detail_bloc.dart';

enum CharacterDetailStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == CharacterDetailStatus.initial;
  bool get isLoading => this == CharacterDetailStatus.loading;
  bool get isSuccess => this == CharacterDetailStatus.success;
  bool get isFailure => this == CharacterDetailStatus.failure;
}

/// {@template character_detail_state}
/// CharacterDetailState description
/// {@endtemplate}
class CharacterDetailState extends Equatable {
  /// {@macro character_detail_state}
  const CharacterDetailState({
    this.status = CharacterDetailStatus.initial,
    this.character = const Character.empty(),
    this.characterImage = '',
    this.characterId = 0,
    this.error,
  });

  /// Status of the state
  final CharacterDetailStatus status;
  final Character character;
  final String characterImage;
  final int characterId;
  final CharacterError? error;

  @override
  List<Object?> get props => [
        status,
        character,
        characterImage,
        characterId,
        error,
      ];

  /// Creates a copy of the current CharacterDetailState with property changes
  CharacterDetailState copyWith({
    CharacterDetailStatus? status,
    Character? character,
    String? characterImage,
    int? characterId,
    CharacterError? error,
  }) {
    return CharacterDetailState(
      status: status ?? this.status,
      character: character ?? this.character,
      characterImage: characterImage ?? this.characterImage,
      characterId: characterId ?? this.characterId,
      error: error ?? this.error,
    );
  }
}
