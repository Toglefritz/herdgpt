import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:herdgpt/screens/landing/landing_route.dart';
import 'package:herdgpt/themes/dark_theme.dart';
import 'package:herdgpt/themes/light_theme.dart';

/// Wraps the entire app and returns the root [MaterialApp] widget, along with its theme data.

class HerdGPTApp extends StatelessWidget {
  const HerdGPTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HirePrep',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LandingRoute(),
    );
  }
}
