import 'dart:collection' show UnmodifiableListView;

import 'package:bloc_implementation/bloc_implementation.dart' show BlocParent;
import 'package:bull_throw/blocs/homescreen_bloc.dart';
import 'package:bull_throw/blocs/settings_bloc.dart';
import 'package:bull_throw/blocs/x01_bloc.dart';
import 'package:bull_throw/blocs/x01_config_bloc.dart';
import 'package:bull_throw/models/player.dart';
import 'package:bull_throw/routes.dart';
import 'package:bull_throw/views/error_screen.dart';
import 'package:bull_throw/views/homescreen.dart';
import 'package:bull_throw/views/settings_screen.dart';
import 'package:bull_throw/views/x01_config_screen.dart';
import 'package:bull_throw/views/x01_screen.dart';
import 'package:flutter/cupertino.dart' show CupertinoScrollBehavior;
import 'package:flutter/material.dart';
import 'package:modern_themes/modern_themes.dart' show Themes;
import 'package:string_translate/string_translate.dart'
    show Translation, TranslationLocales, TranslationDelegates;

void main() {
  runApp(const BullThrowApp());
}

final class BullThrowApp extends StatefulWidget {
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
      /* Debug Data */
      debugShowCheckedModeBanner: true,
      debugShowMaterialGrid: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,

      /* General data */
      scrollBehavior: const CupertinoScrollBehavior(),

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
        Routes.settings:
            (_) => BlocParent(bloc: SettingsBloc(), child: SettingsScreen()),
      },
      onGenerateRoute: (settings) {
        final Widget widget;
        switch (settings.name) {
          case Routes.x01:
            widget = BlocParent(
              bloc: X01Bloc(settings.arguments as UnmodifiableListView<Player>),
              child: X01Screen(),
            );
            break;
          default:
            widget = ErrorScreen();
            break;
        }
        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}
