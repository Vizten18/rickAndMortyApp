part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeOnStart extends HomeEvent {
  const HomeOnStart();
}

class HomeOnRefresh extends HomeEvent {
  const HomeOnRefresh();
}

class HomeOnScrollEndReached extends HomeEvent {
  const HomeOnScrollEndReached();
}
