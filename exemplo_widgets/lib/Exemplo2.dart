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
          title: Text('Exemplo de Lista com Ícones'),
        ),
        body: ListView.builder(
          itemCount: 5, // Número de itens na lista
          itemBuilder: (context, index) {
            // Ícone específico para cada item
            IconData iconData = Icons.home;

            switch (index % 3) {
              case 0:
                iconData = Icons.home;
                break;
              case 1:
                iconData = Icons.work;
                break;
              case 2:
                iconData = Icons.school;
                break;
            }

            return ListTile(
              leading: Icon(iconData), // Ícone à esquerda
              title: Row(
                children: [
                  Icon(Icons.person), // Ícone relacionado ao texto
                  SizedBox(width: 8), // Espaçamento entre o ícone e o texto
                  Text('Nome $index'), // Nome
                ],
              ),
              subtitle: Text('Idade: $index anos\nEndereço: Endereço $index\nTelefone: (00) 0000-0000\nE-mail: email$index@example.com'), // Outras informações
            );
          },
        ),
      ),
    );
  }
}
