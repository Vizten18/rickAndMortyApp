import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    required RouterConfig<Object> routerConfig,
    super.key,
  }) : _routerConfig = routerConfig;

  final RouterConfig<Object> _routerConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
