import 'package:flutter/material.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.dark;

  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }
}
