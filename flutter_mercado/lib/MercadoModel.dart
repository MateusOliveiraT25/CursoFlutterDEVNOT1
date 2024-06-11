import 'package:flutter/material.dart';
import 'categorias.dart';

class ListaCompra {
  late String descricao;
  bool concluida;
  late Categoria categoria;
  DateTime dataHora;

  ListaCompra(this.descricao, this.concluida, this.categoria) : dataHora = DateTime.now();
}