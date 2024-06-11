import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/ajuda-suporte');
              },
              icon: Icon(Icons.help),
              label: Text('Ajuda e Suporte'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/mercado');
              },
              icon: Icon(Icons.shopping_cart),
              label: Text('Mercado'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _logout(context);
              },
              icon: Icon(Icons.logout),
              label: Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
   Future<void> _logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (int i = 0; prefs.getString('item_$i') != null; i++) {
    await prefs.remove('item_$i');
  }
}
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
