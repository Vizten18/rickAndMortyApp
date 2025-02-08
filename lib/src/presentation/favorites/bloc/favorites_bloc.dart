import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required GetFavorites getFavorites,
    required DislikeCharacter dislikeCharacter,
  })  : _getFavorites = getFavorites,
        _dislikeCharacter = dislikeCharacter,
        super(const FavoritesState()) {
    on<FavoritesOnStart>(_onStart);
    on<UpdateFavorites>(_updateFavorites);
    on<UpdateDislikes>(_updateDislikes);
    on<FavoritesOnDislike>(_onDislike);
    add(const FavoritesOnStart());

    _getFavorites.characters.listen((character) {
      add(UpdateFavorites(character: character));
    });

    _getFavorites.dislikedCharacters.listen((id) {
      add(UpdateDislikes(id: id));
    });
  }

  final GetFavorites _getFavorites;
  final DislikeCharacter _dislikeCharacter;

  Future<void> _onStart(
    FavoritesOnStart event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    final result = await _getFavorites.execute();

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: FavoritesStatus.success,
            characters: data,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: FavoritesStatus.failure,
          ),
        );
      },
    );
  }

  Future<void> _onDislike(
    FavoritesOnDislike event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await _dislikeCharacter.execute(event.character.id);

    result.resolve(
      (_) {
        final updatedCharacters = List<Character>.from(state.characters)
          ..removeWhere((character) => character.id == event.character.id);
        emit(
          state.copyWith(
            characters: updatedCharacters,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: FavoritesStatus.failure,
          ),
        );
      },
    );
  }

  void _updateFavorites(
    UpdateFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    final updatedCharacters = List<Character>.from(state.characters)
      ..add(event.character);
    emit(
      state.copyWith(
        characters: updatedCharacters,
      ),
    );
  }

  void _updateDislikes(
    UpdateDislikes event,
    Emitter<FavoritesState> emit,
  ) {
    final updatedCharacters = List<Character>.from(state.characters)
      ..removeWhere((character) => character.id == event.id);
    emit(
      state.copyWith(
        characters: updatedCharacters,
      ),
    );
  }
}
