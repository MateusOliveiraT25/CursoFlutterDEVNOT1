import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> churrascoItems = [
    'Picanha',
    'Costela',
    'Maminha',
    'Frango',
    'Linguicinha',
    'Asa de frango',
    'Queijo coalho',
    'Pão de alho',
    'Alcatra',
    'Cupim',
  ];

  final List<String> churrascoDescriptions = [
    'A mais nobre das carnes brasileiras, macia e suculenta.',
    'Carne saborosa e com bastante gordura, ideal para assados de longa duração.',
    'Corte de carne macia e suculenta, com sabor marcante.',
    'Carne de frango macia e suculenta, ideal para churrascos rápidos.',
    'Linguiça temperada e suculenta, perfeita para churrascos.',
    'Parte saborosa do frango, ideal para petiscos.',
    'Queijo firme que derrete na grelha, ótimo para acompanhar a carne.',
    'Pão temperado e assado na churrasqueira, perfeito como acompanhamento.',
    'Corte de carne macia e suculenta, ótimo para churrascos.',
    'Corte suculento e saboroso, ideal para assados de longa duração.',
  ];
final List<IconData> churrascoIcons = [
  Icons.local_dining, // Picanha
  Icons.local_fire_department, // Costela
  Icons.restaurant_menu, // Maminha
  Icons.local_drink, // Frango
  Icons.fastfood, // Linguicinha
  Icons.local_pizza, // Asa de frango
  Icons.emoji_food_beverage, // Queijo coalho
  Icons.food_bank, // Pão de alho
  Icons.restaurant, // Alcatra
  Icons.local_bar, // Cupim
];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Churrasco'),
        ),
        body: ListView.builder(
          itemCount: churrascoItems.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(churrascoIcons[index]), // Ícone do item de churrasco
                title: Text(churrascoItems[index]),
                subtitle: Text(churrascoDescriptions[index]),
                onTap: () {
                 ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Você selecionou ${churrascoItems[index]}'),

        ),
  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
