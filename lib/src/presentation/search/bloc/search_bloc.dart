// ignore_for_file: lines_longer_than_80_chars, curly_braces_in_flow_control_structures

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required SearchCharacter searchCharacter,
  })  : _searchCharacter = searchCharacter,
        super(SearchState()) {
    on<SearchOnOpenModalFilter>(_onOpenModal);
    on<SearchOnCloseModalFilter>(_onCloseModal);
    on<SearchOnFilterChanged>(_onFilterChanged);
    on<SearchOnTextChanged>(_onTextChanged);
    on<SearchOnRefresh>(_onRefresh);
    on<SearchOnScrollEndReached>(_onScrollEnded);
  }

  final SearchCharacter _searchCharacter;

  void _onOpenModal(
    SearchOnOpenModalFilter event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(modalFilterStatus: ModalFilterStatus.show));
  }

  void _onCloseModal(
    SearchOnCloseModalFilter event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(modalFilterStatus: ModalFilterStatus.hide));
  }

  Future<void> _onFilterChanged(
    SearchOnFilterChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        statusSelected: event.characterStatus ?? state.statusSelected,
        genderSelected: event.genderTypes ?? state.genderSelected,
        currentPage: 1,
        characters: [],
      ),
    );

    final result = await _searchCharacter.execute(state.searchParameters);

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            characters: data.items,
            pageInfo: data.pageInfo,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: SearchStatus.failure,
            error: error,
          ),
        );
      },
    );
  }

  Future<void> _onTextChanged(
    SearchOnTextChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        searchText: event.text,
        currentPage: 1,
        characters: [],
      ),
    );
    final result = await _searchCharacter.execute(state.searchParameters);

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            characters: data.items,
            pageInfo: data.pageInfo,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: SearchStatus.failure,
            error: error,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    SearchOnRefresh event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SearchStatus.loading,
        currentPage: 1,
        characters: [],
      ),
    );

    final result = await _searchCharacter.execute(state.searchParameters);

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            characters: data.items,
            pageInfo: data.pageInfo,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: SearchStatus.failure,
            error: error,
          ),
        );
      },
    );
  }

  Future<void> _onScrollEnded(
    SearchOnScrollEndReached event,
    Emitter<SearchState> emit,
  ) async {
    if (state.paginationStatus.isLoading ||
        (state.pageInfo?.nextPage.isEmpty ?? true)) {
      return;
    }

    emit(state.copyWith(paginationStatus: SearchStatus.loading));

    final nextPage = state.currentPage + 1;

    final result = await _searchCharacter.execute(
      state.searchParameters.copyWith(page: nextPage),
    );

    result.resolve(
      (data) {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            paginationStatus: SearchStatus.success,
            characters: [...state.characters, ...data.items],
            pageInfo: data.pageInfo,
            currentPage: nextPage,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            status: SearchStatus.failure,
            error: error,
          ),
        );
      },
    );
  }
}
