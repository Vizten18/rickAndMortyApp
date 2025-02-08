import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/l10n/l10n.dart';
import 'package:rick_and_morty_app/src/domain/repositories/repositories.dart';

class App extends StatelessWidget {
  const App({
    required RouterConfig<Object> routerConfig,
    required ICharacterRepository characterRepository,
    super.key,
  })  : _routerConfig = routerConfig,
        _characterRepository = characterRepository;

  final RouterConfig<Object> _routerConfig;
  final ICharacterRepository _characterRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _characterRepository),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _routerConfig,
      ),
    );
  }
}
