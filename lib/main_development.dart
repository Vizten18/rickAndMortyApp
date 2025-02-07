import 'package:rick_and_morty_app/bootstrap.dart';
import 'package:rick_and_morty_app/routes/router.dart';
import 'package:rick_and_morty_app/src/app.dart';

void main() {
  bootstrap(
    () => App(
      routerConfig: AppRouter.router(debug: true),
    ),
  );
}
