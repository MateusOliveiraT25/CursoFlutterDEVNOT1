import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listagem Dinâmica',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listagem Dinâmica'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(items[index]),
                subtitle: Text('Descrição do item $index'),
                leading: Icon(Icons.shopping_cart),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Ação ao clicar no item
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
