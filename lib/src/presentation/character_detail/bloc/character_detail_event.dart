part of 'character_detail_bloc.dart';

abstract class CharacterDetailEvent extends Equatable {
  const CharacterDetailEvent();

  @override
  List<Object> get props => [];
}

class CharacterDetailOnStart extends CharacterDetailEvent {
  const CharacterDetailOnStart();
}

class CharacterDetailOnLikePressed extends CharacterDetailEvent {
  const CharacterDetailOnLikePressed();
}
