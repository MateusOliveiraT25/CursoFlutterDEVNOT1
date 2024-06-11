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
          title: Text('Layout com Container'),
        ),
        body: Center(
          child: Container(
            // Define a largura e altura do Container principal
            width: 500,
            height: 500,
            // Define a cor de fundo do Container principal
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Widget 1: Texto com estilo branco e tamanho de fonte 20
                Text(
                  'Widget 1',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 20), // Espaçamento entre os widgets
                // Widget 2: Container verde com tamanho 100x50
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.orange,
                  child: Center(
                    // Texto "Widget 2" com estilo branco
                    child: Text(
                      'Widget 2',
                      style: TextStyle(color: Color.fromRGBO(241, 241, 241, 1)),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Espaçamento entre os widgets
                // Widget 3: Container laranja com tamanho 150x100
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: Center(
                    // Texto "Widget 3" com estilo branco
                    child: Text(
                      'Widget 3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}