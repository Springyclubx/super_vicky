import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'domain/constants/route_default.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'infrastructure/presentation/constants/color_default_constants.dart';
import 'infrastructure/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'infrastructure/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: android,
  );
  runApp(const HomePage());
}

/// Colors default on program
late final ColorDefaultConstants colorDefault;
bool _isColorDefaultInitialized = false;

/// Widget with configurations application include [MaterialApp]
class HomePage extends StatelessWidget {
  /// Default constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!_isColorDefaultInitialized) {
      _init(context);
    }

    final theme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes(),
      initialRoute: RouteDefault.mainScreen,
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'en'),
        Locale.fromSubtags(languageCode: 'pt'),
        Locale.fromSubtags(languageCode: 'es'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      theme: ThemeData(
        dividerTheme: DividerThemeData(color: colorDefault.offColor),
        scaffoldBackgroundColor: colorDefault.backGroundColor,
        primaryColor: colorDefault.mainColor,
        cardColor: colorDefault.mainColor,
        cardTheme: CardThemeData(color: colorDefault.mainColor),
        textTheme: TextTheme(
          bodyLarge: theme.bodyLarge?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          bodyMedium: theme.bodyMedium?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          bodySmall: theme.bodySmall?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          displayLarge: theme.displayLarge?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          displayMedium: theme.displayMedium?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          displaySmall: theme.displaySmall?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          headlineLarge: theme.headlineLarge?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          headlineMedium: theme.headlineMedium?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          headlineSmall: theme.headlineSmall?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          labelLarge: theme.labelLarge?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          labelMedium: theme.labelMedium?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          labelSmall: theme.labelSmall?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          titleLarge: theme.titleLarge?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          titleMedium: theme.titleMedium?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
          titleSmall: theme.titleSmall?.copyWith(
            fontFamily: 'inter',
            color: colorDefault.offColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: colorDefault.offColor,
        ),
        listTileTheme: ListTileThemeData(iconColor: colorDefault.offColor),
        expansionTileTheme: ExpansionTileThemeData(
          iconColor: colorDefault.offColor,
          collapsedIconColor: colorDefault.offColor,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll<Color>(colorDefault.offColor),
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorDefault.mainColor,
          foregroundColor: colorDefault.offColor,
        ),
        appBarTheme: AppBarTheme(backgroundColor: colorDefault.mainColor),
      ),
      home: const MainScreen(),
    );
  }

  void _init(BuildContext context) {
    _isColorDefaultInitialized = true;
    colorDefault = ColorDefaultConstants(context: context);
  }
}
