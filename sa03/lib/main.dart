import 'package:flutter/material.dart';
import 'package:sa03/AjudaSuportePage.dart';
import 'package:sa03/LoginPage.dart';
import 'package:sa03/MeuPerfilPage.dart'; // Importe a página do perfil do usuário
import 'package:sa03/HomePage.dart';
import 'package:sa03/MercadoPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Aplicação',
       debugShowCheckedModeBanner: false,
      initialRoute: '/', // Rota inicial, redireciona para a página de login
      routes: {
        '/': (context) => LoginScreen(), // Página de login
        '/home': (context) => HomeScreen(), // Página de home após o login
        '/meu-perfil': (context) => MeuPerfilPage(email: ''), // Adapte conforme necessário
        '/ajuda-suporte': (context) => AjudaSuportePage(),
        '/mercado': (context) => MercadoApp(email: ''),
      },
    );
  }
}