import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Responsivo'),
        ),
        body: ResponsiveLayout(),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém o tamanho da tela
    final Size screenSize = MediaQuery.of(context).size;

    // Exemplo de layout responsivo
    if (screenSize.width > 600) {
      return WideLayout(); // Exibe o layout amplo para telas largas
    } else {
      return NarrowLayout(); // Exibe o layout estreito para telas estreitas
    }
  }
}

class WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        color: Colors.green, // Cor verde para o layout amplo
        child: Text(
          'Wide Layout',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.yellow, // Cor amarela para o layout estreito
        child: Text(
          'Narrow Layout',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
