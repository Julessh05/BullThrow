import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:bull_throw/blocs/x01_config_bloc.dart';
import 'package:bull_throw/routes.dart';
import 'package:bull_throw/views/homescreen.dart';
import 'package:bull_throw/views/x01_config_screen.dart';
import 'package:bull_throw/views/x01_screen.dart';
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart' show Themes;
import 'package:string_translate/string_translate.dart'
    show Translation, TranslationLocales, TranslationDelegates;

import 'blocs/homescreen_bloc.dart';

void main() {
  runApp(const BullThrowApp());
}

class BullThrowApp extends StatefulWidget {
  const BullThrowApp({super.key});

  @override
  State<BullThrowApp> createState() => _BullThrowAppState();
}

class _BullThrowAppState extends State<BullThrowApp> {
  @override
  void initState() {
    Translation.init(
      supportedLocales: TranslationLocales.all,
      defaultLocale: TranslationLocales.english,
      // TODO: add translations
      translations: {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* Locale */
      locale: Translation.activeLocale,
      supportedLocales: Translation.supportedLocales,
      localizationsDelegates: TranslationDelegates.localizationDelegates,

      /* Themes */
      themeMode: Themes.themeMode,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      highContrastTheme: Themes.highContrastLightTheme,
      highContrastDarkTheme: Themes.highContrastDarkTheme,

      /* Routes */
      initialRoute: Routes.home,
      routes: {
        Routes.home:
            (_) => BlocParent(bloc: HomescreenBloc(), child: Homescreen()),
        Routes.x01Config:
            (_) => BlocParent(bloc: X01ConfigBloc(), child: X01ConfigScreen()),
        Routes.x01:
            (_) => BlocParent(bloc: X01ConfigBloc(), child: X01Screen()),
      },
    );
  }
}