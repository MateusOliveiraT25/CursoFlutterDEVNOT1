import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/configuracoes');
              },
              icon: Icon(Icons.settings),
              label: Text('Ir para Configurações'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/meu-perfil');
              },
              icon: Icon(Icons.person),
              label: Text('Meu Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
