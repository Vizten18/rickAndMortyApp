// ignore_for_file: curly_braces_in_flow_control_structures, lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetCharacters getCharacters,
  })  : _getCharacters = getCharacters,
        super(const HomeState()) {
    on<HomeOnStart>(_onStart);
    on<HomeOnRefresh>(_onRefresh);
    on<HomeOnScrollEndReached>(_onScrollEndReached);
    add(const HomeOnStart());
  }

  final GetCharacters _getCharacters;

  Future<void> _onStart(
    HomeOnStart event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await _getCharacters.execute(1);

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: HomeStatus.success,
            characters: data.items,
            pageInfo: data.pageInfo,
            currentPage: 1,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            error: result.error,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    HomeOnRefresh event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await _getCharacters.execute(1);

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: HomeStatus.success,
            characters: data.items,
            pageInfo: data.pageInfo,
            currentPage: 1,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            error: result.error,
          ),
        );
      },
    );
  }

  Future<void> _onScrollEndReached(
    HomeOnScrollEndReached event,
    Emitter<HomeState> emit,
  ) async {
    if (state.paginationStatus.isLoading || state.pageInfo?.nextPage == null)
      return;

    emit(state.copyWith(paginationStatus: HomeStatus.loading));

    final nextPage = state.currentPage + 1;
    final result = await _getCharacters.execute(nextPage);

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            paginationStatus: HomeStatus.success,
            characters: List.of(state.characters)..addAll(data.items),
            pageInfo: data.pageInfo,
            currentPage: nextPage,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            paginationStatus: HomeStatus.failure,
            error: result.error,
          ),
        );
      },
    );
  }
}
