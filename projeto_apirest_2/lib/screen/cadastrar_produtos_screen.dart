import 'package:projeto_apirest_2/controllers/produtos_controller.dart';
import 'package:flutter/material.dart';
import 'package:projeto_apirest_2/model/produto.dart';

class CadastrarProdutoScreen extends StatefulWidget {
  const CadastrarProdutoScreen({super.key});

  @override
  State<CadastrarProdutoScreen> createState() => _CadastrarProdutoScreenState();
}

class _CadastrarProdutoScreenState extends State<CadastrarProdutoScreen> {
  final ProdutosController _controller = ProdutosController();
  final TextEditingController _nomeText = TextEditingController();
  final TextEditingController _codigoText = TextEditingController();
  final TextEditingController _precoText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getProdutos();
  }

  // postProduto
  Future<void> _postProduto() async {
    Produto produto = Produto(
        id: (_controller.listProdutos.length + 1).toString(),
        nome: _nomeText.text,
        codigo: _codigoText.text,
        preco: double.tryParse(_precoText.text) ?? 0.0);
    try {
      await _controller.postProduto(produto);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeText,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
            ),
            TextField(
              controller: _codigoText,
              decoration: const InputDecoration(
                labelText: "Código",
              ),
            ),
            TextField(
              controller: _precoText,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço",
              ),
            ),
            ElevatedButton(
              onPressed: _cadastrar(),
              child: const Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback _cadastrar() {
    return () {
      _postProduto();
      // Limpar os campos após o cadastro
      _nomeText.clear();
      _codigoText.clear();
      _precoText.clear();
    };
  }
}
