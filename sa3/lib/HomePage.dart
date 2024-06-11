import 'package:flutter/material.dart';
import 'package:sa2/ConfiguracoesPage.dart';
import 'package:sa2/AjudaSuportePage.dart'; 
import 'package:sa2/MercadoView.dart';
 // Importe a página do perfil do usuário


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
       actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfiguracoesPage(email: '',)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.help), // Ícone para a página de Ajuda e Suporte
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AjudaSuportePage()), // Navega para a página de Ajuda e Suporte
                  );
                },
              ),
               IconButton(
                icon: Icon(Icons.help), // Ícone para a página de Ajuda e Suporte
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MercadoScreen()), // Navega para a página de Ajuda e Suporte
                  );
                },
              ),
       ]
      )
    );
  }
  }