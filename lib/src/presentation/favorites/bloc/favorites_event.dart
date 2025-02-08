part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesOnStart extends FavoritesEvent {
  const FavoritesOnStart();
}

class FavoritesOnDislike extends FavoritesEvent {
  const FavoritesOnDislike({
    required this.character,
  });

  final Character character;

  @override
  List<Object> get props => [character];
}

class UpdateFavorites extends FavoritesEvent {
  const UpdateFavorites({
    required this.character,
  });

  final Character character;

  @override
  List<Object> get props => [character];
}

class UpdateDislikes extends FavoritesEvent {
  const UpdateDislikes({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}