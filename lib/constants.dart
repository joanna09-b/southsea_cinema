import 'package:flutter/material.dart';

const String appTitle = 'Southsea Cinema';

const String prefThemeMode = 'theme_mode';
const String prefThemeDark = 'dark';
const String prefThemeLight = 'light';

const Color cinemaBrand = Color(0xFF55BEDE);
const Color cinemaBrandLight = Color(0xFF7FCEE6);
const Color cinemaBrandDark = Color(0xFF3FB5D9);

const Color cinemaBackground = Color(0xFF1B1E28);
const Color cinemaBackgroundLight = Color(0xFFF4F6FA);
const Color cinemaFontWhite = Color(0xFFFFFFFF);
const Color cinemaFontDark = Color(0xFF1B1E28);
const Color cinemaFontMuted = Color(0xFF8A90A0);
const Color cinemaSurface = Color(0xFF242936);
const Color cinemaSurfaceLight = Color(0xFFFFFFFF);

const TextStyle cinemaHeaderStyle = TextStyle(
  color: cinemaFontWhite,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

ThemeMode themeModeFromPreference(String? value) {
  if (value == prefThemeLight) {
    return ThemeMode.light;
  }
  return ThemeMode.dark;
}

String themeModeToPreference(ThemeMode mode) {
  if (mode == ThemeMode.light) {
    return prefThemeLight;
  }
  return prefThemeDark;
}
