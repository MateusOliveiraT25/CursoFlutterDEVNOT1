import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa2_autenticacao_configuracao/ThemeProvider.dart';
import 'package:sa2_autenticacao_configuracao/View/tela_configuracao.dart'; // Importe o arquivo onde está definido o ThemeProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MaterialApp(
        home: TelaConfiguracoes(), // Defina TelaConfiguracoes como a tela inicial
      ),
    ),
  );
}
