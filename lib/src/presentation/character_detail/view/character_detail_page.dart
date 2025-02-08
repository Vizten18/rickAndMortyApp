// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';

import 'package:rick_and_morty_app/src/presentation/character_detail/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/presentation/character_detail/widgets/character_detail_body.dart';

/// {@template character_detail_page}
/// A description for CharacterDetailPage
/// {@endtemplate}
///

class CharacterDetailParams {
  final int characterId;
  final String characterImage;
  final String pathPrefix;

  CharacterDetailParams({
    required this.characterId,
    required this.characterImage,
    required this.pathPrefix,
  });

  factory CharacterDetailParams.fromMap(Map<String, String> map) {
    return CharacterDetailParams(
      characterId: int.parse(map['characterId'] ?? '0'),
      characterImage: map['characterImage'] ?? '',
      pathPrefix: map['pathPrefix'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'characterId': characterId.toString(),
      'characterImage': characterImage,
      'pathPrefix': pathPrefix,
    };
  }

  String get toQueryParams {
    final queryParas = toMap();
    final queryString = Uri(queryParameters: queryParas).query;
    return queryString;
  }
}

class CharacterDetailPage extends StatelessWidget {
  /// {@macro character_detail_page}
  const CharacterDetailPage({
    required this.params,
    super.key,
  });

  final CharacterDetailParams params;

  /// The route name of CharacterDetailPage. Use to navigate
  /// with named routes.
  static const routeName = 'character-detail';

  /// Generates the full path for CharacterDetailPage based on the pathPrefix.
  static String generatePath(CharacterDetailParams params) {
    return '${params.pathPrefix}/$routeName?${params.toQueryParams}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterDetailBloc(
        getCharacterById: GetCharacterById(characterRepository: context.read()),
        characterId: params.characterId,
        characterImage: params.characterImage,
        likeCharacter: LikeCharacter(
          characterRepository: context.read(),
        ),
        dislikeCharacter: DislikeCharacter(
          characterRepository: context.read(),
        ),
      ),
      child: const Scaffold(
        body: CharacterDetailView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of CharacterDetail here to handle navigation, showing dialogs, etc.
/// {@template character_detail_view}
/// Displays the Body of CharacterDetailView
/// {@endtemplate}
///
class CharacterDetailView extends StatelessWidget {
  /// {@macro character_detail_view}
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CharacterDetailBody();
  }
}
