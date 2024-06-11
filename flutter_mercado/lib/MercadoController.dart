import 'package:flutter/material.dart';
import 'MercadoModel.dart'; // Importe o modelo ListaCompra
import 'categorias.dart'; // Importe o arquivo categorias.dart que contém a enumeração Categoria

// Classe responsável por gerenciar a lista de compras
class ListaCompraController extends ChangeNotifier {
  List<ListaCompra> _lista = []; // Lista de itens da lista de compras

  // Getter para acessar a lista de compras
  List<ListaCompra> get lista => _lista;

  // Método para adicionar um item à lista de compras
  void adicionarListaCompra(String descricao, Categoria categoria) { // verifica se há algum item na lista que tenha a mesma descrição e categoria
    if (descricao.isNotEmpty) {
      bool jaExiste = _lista.any((item) =>
          item.descricao.toLowerCase() == descricao.toLowerCase() &&
          item.categoria == categoria);
      if (!jaExiste) {
        _lista.add(ListaCompra(descricao, false, categoria)); // Adiciona o item à lista
        notifyListeners(); // Notifica os ouvintes (como a interface do usuário) sobre a mudança na lista
      }
    }
  }

  // Método para marcar um item como concluído ou não concluído
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _lista.length) {
      _lista[indice].concluida = !_lista[indice].concluida; // Inverte o status de concluído
      notifyListeners(); // Notifica os ouvintes sobre a mudança
    }
  }

  // Método para excluir um item da lista de compras
  void excluirListaCompra(int indice) {
    if (indice >= 0 && indice < _lista.length) {
      _lista.removeAt(indice); // Remove o item da lista
      notifyListeners(); // Notifica os ouvintes sobre a mudança
    }
  }

  // Método para ordenar a lista de compras por categoria
  void ordenarPorCategoria() {
    _lista.sort((a, b) => a.categoria.nome.compareTo(b.categoria.nome)); // Ordena os itens pela categoria
    notifyListeners(); // Notifica os ouvintes sobre a mudança na ordem
  }

  // Método para editar a descrição de um item da lista de compras
// Método para editar um item da lista de compras
void editarTarefa(int indice, String novaDescricao, Categoria novaCategoria) {
  if (indice >= 0 && indice < _lista.length) {
    _lista[indice].descricao = novaDescricao; // Atualiza a descrição
    _lista[indice].categoria = novaCategoria; // Atualiza a categoria
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }
}
}
