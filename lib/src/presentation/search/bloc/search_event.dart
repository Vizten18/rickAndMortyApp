part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchOnOpenModalFilter extends SearchEvent {
  const SearchOnOpenModalFilter();
}

class SearchOnCloseModalFilter extends SearchEvent {
  const SearchOnCloseModalFilter();
}

class SearchOnTextChanged extends SearchEvent {
  const SearchOnTextChanged({
    required this.text,
  });

  final String text;

  @override
  List<Object> get props => [text];
}

class SearchOnFilterChanged extends SearchEvent {
  const SearchOnFilterChanged({
    this.characterStatus,
    this.genderTypes,
  });

  final CharacterStatus? characterStatus;
  final GenderType? genderTypes;
}

class SearchOnRefresh extends SearchEvent {
  const SearchOnRefresh();
}

class SearchOnScrollEndReached extends SearchEvent {
  const SearchOnScrollEndReached();
}
