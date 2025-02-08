import 'package:rick_and_morty_app/bootstrap.dart';
import 'package:rick_and_morty_app/routes/router.dart';
import 'package:rick_and_morty_app/src/app.dart';
import 'package:rick_and_morty_app/src/data/data_sources/data_sources.dart';
import 'package:rick_and_morty_app/src/data/repositories/repositories.dart';

void main() {
  bootstrap(
    () => App(
      routerConfig: AppRouter.router(debug: true),
      characterRepository: CharacterRepository(
        characterApi: RickAndMortyApiRest(),
      ),
    ),
  );
}
