import 'package:flutter/material.dart';
import 'MercadoController.dart';
import 'MercadoView.dart';
import 'package:provider/provider.dart';

class MercadoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 250, 18, 215),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
        // Outras definições de cores
      ),
      home: ChangeNotifierProvider(
        create: (context) => ListaCompraController(),
        child: MercadoScreen(),
      ),
    );
  }
}
