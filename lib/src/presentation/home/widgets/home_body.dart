import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/presentation/home/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/presentation/home/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isFailure) {
          return CharacterErrorBuilder(
            errorType: state.error!.characterErrorType,
          );
        }

        return const CharacterList();
      },
    );
  }
}
