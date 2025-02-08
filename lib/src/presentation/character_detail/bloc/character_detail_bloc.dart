// ignore_for_file: cascade_invocations

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';
part 'character_detail_event.dart';
part 'character_detail_state.dart';

class CharacterDetailBloc
    extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  CharacterDetailBloc({
    required GetCharacterById getCharacterById,
    required LikeCharacter likeCharacter,
    required DislikeCharacter dislikeCharacter,
    required int characterId,
    required String characterImage,
  })  : _getCharacterById = getCharacterById,
        _likeCharacter = likeCharacter,
        _dislikeCharacter = dislikeCharacter,
        super(
          CharacterDetailState(
            characterImage: characterImage,
            characterId: characterId,
          ),
        ) {
    on<CharacterDetailOnStart>(_onStart);
    on<CharacterDetailOnLikePressed>(_onLikePressed);
    add(const CharacterDetailOnStart());
  }

  final GetCharacterById _getCharacterById;
  final LikeCharacter _likeCharacter;
  final DislikeCharacter _dislikeCharacter;

  Future<void> _onStart(
    CharacterDetailOnStart event,
    Emitter<CharacterDetailState> emit,
  ) async {
    emit(state.copyWith(status: CharacterDetailStatus.loading));

    final result = await _getCharacterById.execute(state.characterId);

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: CharacterDetailStatus.success,
            character: data,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: CharacterDetailStatus.failure,
            error: result.error,
          ),
        );
      },
    );
  }

  Future<void> _onLikePressed(
    CharacterDetailOnLikePressed event,
    Emitter<CharacterDetailState> emit,
  ) async {
    final isLiked = state.character.liked;
    final result = isLiked
        ? await _dislikeCharacter.execute(state.characterId)
        : await _likeCharacter.execute(state.character);

    result.resolve(
      (_) {
        emit(
          state.copyWith(
            character: state.character.copyWith(liked: !isLiked),
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: CharacterDetailStatus.failure,
            error: error,
          ),
        );
      },
    );
  }
}
