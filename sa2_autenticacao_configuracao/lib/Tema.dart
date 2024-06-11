import 'package:flutter/material.dart';

// Classe para armazenar e atualizar o tema do aplicativo
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  // Método para obter o tema atual
  ThemeData getTheme() => _themeData;

  // Método para atualizar o tema
  void updateTheme(ThemeData newTheme) {
    _themeData = newTheme;
    notifyListeners(); // Notifica os ouvintes (widgets) que o tema foi atualizado
  }
}
