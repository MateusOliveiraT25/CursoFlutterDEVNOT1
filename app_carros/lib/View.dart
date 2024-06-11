// ignore_for_file: unused_local_variable

import 'package:app_carros/Controller.dart';
import 'package:app_carros/Model.dart';
import 'package:flutter/material.dart';


class TelaListaCarro extends StatelessWidget {
  final CarroController controllerCarros;
  TelaListaCarro(this.controllerCarros);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Carros'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controllerCarros.listarCarros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controllerCarros.listarCarros[index].modelo),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaDetalheCarro(controllerCarros.listarCarros[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adicionarCarro(context, controllerCarros);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _adicionarCarro(BuildContext context, CarroController controllerCarros) {
    TextEditingController modeloController = TextEditingController();
    TextEditingController anoController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Carro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: modeloController,
                decoration: InputDecoration(
                  labelText: 'Modelo do Carro',
                ),
              ),
              TextField(
                controller: anoController,
                decoration: InputDecoration(
                  labelText: 'Ano do Carro',
                ),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL da Imagem do Carro',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String modelo = modeloController.text;
                int ano = int.tryParse(anoController.text) ?? 0;
                String imageUrl = imageUrlController.text;

           Carro novoCarro = Carro(modeloController.text, int.tryParse(anoController.text) ?? 0, imageUrlController.text);


                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

class TelaDetalheCarro extends StatelessWidget {
  final Carro carro;
  TelaDetalheCarro(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Carro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(carro.imageUrl),
            SizedBox(height: 20),
            Text("Modelo: ${carro.modelo}"),
            Text("Ano: ${carro.ano}"),
          ],
        ),
      ),
    );
  }
}
