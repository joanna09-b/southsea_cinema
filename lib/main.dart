import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:southsea_cinema/views/bookings_view.dart';
//import 'package:southsea_cinema/views/movie_listing.dart';

bool isSupportedPlatform() {
  if (kIsWeb) {
    return false;
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    return true;
  }

  return false;
}

void main() {
  runApp(const SouthseaCinemaApp());
}

class SouthseaCinemaApp extends StatefulWidget {
  const SouthseaCinemaApp({super.key});

  @override
  State<SouthseaCinemaApp> createState() => _SouthseaCinemaAppState();
}

class _SouthseaCinemaAppState extends State<SouthseaCinemaApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final String? savedTheme = await prefs.getString(prefThemeMode);

    if (!mounted) {
      return;
    }

    setState(() {
      _themeMode = themeModeFromPreference(savedTheme);
    });
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: cinemaBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: cinemaBrand,
        brightness: Brightness.dark,
        primary: cinemaBrand,
        surface: cinemaSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cinemaSurface,
        iconTheme: IconThemeData(color: cinemaBrand),
        titleTextStyle: cinemaHeaderStyle,
        elevation: 0,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: cinemaBackground,
      ),
      cardTheme: const CardThemeData(
        color: cinemaSurface,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: cinemaBackgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: cinemaBrand,
        brightness: Brightness.light,
        primary: cinemaBrand,
        surface: cinemaSurfaceLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cinemaSurfaceLight,
        iconTheme: IconThemeData(color: cinemaBrand),
        titleTextStyle: TextStyle(
          color: cinemaFontDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: cinemaSurfaceLight,
      ),
    );
  }

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData darkTheme = _buildDarkTheme();
    final ThemeData lightTheme = _buildLightTheme();

    if (!isSupportedPlatform()) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeMode,
        home: const UnsupportedPlatformView(),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/basket': (context) => const BasketView(),
        '/settings': (context) => SettingsView(
              initialThemeMode: _themeMode,
              onThemeModeChanged: _setThemeMode,
            ),
        '/bookings': (context) => const BookingsView(),
        //'/listing': (context) => const MovieListing(),
      },
    );
  }
}

class UnsupportedPlatformView extends StatelessWidget {
  const UnsupportedPlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'This app saves bookings with SQLite and is set up to run on '
              'Android only. Stop the app and run it on an Android emulator '
              'or device instead.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
