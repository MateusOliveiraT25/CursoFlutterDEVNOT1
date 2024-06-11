import 'package:flutter/material.dart';
import 'package:projeto_apirest_2/controllers/produtos_controller.dart';
import 'package:projeto_apirest_2/model/produto.dart';

class DeletarProdutosScreen extends StatefulWidget {
  const DeletarProdutosScreen({super.key});

  @override
  State<DeletarProdutosScreen> createState() => _DeletarProdutosScreenState();
}

class _DeletarProdutosScreenState extends State<DeletarProdutosScreen> {
  final ProdutosController _controller = ProdutosController();

  // Método para obter a lista de produtos
  Future<List<Produto>> getProdutos() async {
    try {
      await _controller.getProdutos();
      return _controller.listProdutos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Método para deletar um produto
  Future<void> _deleteProduto(String id) async {
    try {
      await _controller.deleteProduto(id);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deletar Produtos'),
      ),
      body: FutureBuilder<List<Produto>>(
        future: getProdutos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].nome),
                    subtitle: Text(snapshot.data![index].codigo),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteProduto(snapshot.data![index].id);
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('Nenhum produto encontrado.'),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar produtos: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
