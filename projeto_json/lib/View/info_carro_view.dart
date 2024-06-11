import 'dart:io';

import 'package:flutter/material.dart';
import '../Model/carros_model.dart';

class CarroInfoPage extends StatelessWidget {
  final Carro info;
  CarroInfoPage({required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibição da imagem do carro
            Image.file(
              File(info.foto), // Carrega a imagem do arquivo usando o caminho fornecido
              width: double.infinity, // Largura da imagem ocupando toda a largura da tela
              height: 200, // Altura fixa da imagem
              fit: BoxFit.cover, // Ajusta o tamanho da imagem para cobrir o espaço disponível
            ),
            // Exibição das informações do carro
             Text('Placa:${info.placa}'), 
            Text('Modelo:${info.modelo}'), // Exibe o modelo do carro
            Text('Marca:${info.marca}'), // Exibe a marca do carro
            Text('Ano:${info.ano.toString()}'), // Exibe o ano do carro convertido para string
            Text('Cor:${info.cor}'), // Exibe a cor do carro
            Text('Descrição:${info.descricao}'), // Exibe a descrição do carro
            Text('Valor:${info.valor.toString()}'), // Exibe o valor do carro convertido para string
          ],
        ),
      ),
    );
  }
}
