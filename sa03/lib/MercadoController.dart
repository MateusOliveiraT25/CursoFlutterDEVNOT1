import 'package:flutter/material.dart';
import 'MercadoModel.dart'; // Ensure this imports the ListaCompra model correctly
import 'categorias.dart'; // Ensure this imports the Categoria enumeration

// Classe responsável por gerenciar a lista de compras
class ListaCompraController extends ChangeNotifier {
  User user;
  List<ListaCompra> lista;// Lista de itens da lista de compras


  ListaCompraController(this.user, this.lista);
  // Getter para acessar a lista de compras
  List<ListaCompra> get lista => _lista;

  // Método para adicionar um item à lista de compras
<<<<<<< HEAD
void adicionarListaCompra(String descricao, Categoria categoria) {
  if (descricao.isNotEmpty) {
    bool jaExiste = _lista.any((item) =>
        item.descricao.toLowerCase() == descricao.toLowerCase() &&
        item.categoria == categoria);
    if (!jaExiste) {
      _lista.add(ListaCompra(
        descricao: descricao,
        concluida: false,
        categoria: categoria,
        // Adicione os valores padrão ou null para os parâmetros requeridos
        email: '', // valor padrão ou null
        senha: '', // valor padrão ou null
        nome: '', // valor padrão ou null
      ));
      notifyListeners(); // Notifica os ouvintes sobre a mudança na lista
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
=======
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
>>>>>>> 0e1d2799d375b94523f8684374b695bcd0a45520

  // Método para ordenar a lista de compras por categoria
  void ordenarPorCategoria() {
    _lista.sort((a, b) => a.categoria.toString().compareTo(b.categoria.toString())); // Adapted to use toString if Categoria is an enum
    notifyListeners(); // Notifica os ouvintes sobre a mudança na ordem
  }

  // Método para editar um item da lista de compras
  void editarListaCompra(int indice, String novaDescricao, Categoria novaCategoria) {
    if (indice >= 0 && indice < _lista.length) {
      _lista[indice].descricao = novaDescricao; // Atualiza a descrição
      _lista[indice].categoria = novaCategoria; // Atualiza a categoria
      notifyListeners(); // Notifica os ouvintes sobre a mudança
    }
  }

}