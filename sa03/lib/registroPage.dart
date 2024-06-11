import 'package:flutter/material.dart';
import 'package:sa03/categorias.dart';
import 'MercadoModel.dart'; // Importe o modelo de usuário
import 'package:sa03/Controller.dart'; // Importe a classe BancoDadosCrud

// Tela de cadastro de usuário
class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: CadastroForm(),
      ),
    );
  }
}

// Formulário de cadastro de usuário
class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

 void cadastrarUsuario(BuildContext context) async {
    String name = _nomeController.text;
    String email = _emailController.text;
    String password = _senhaController.text;

    BancoDadosCrud bancoDados = BancoDadosCrud();

    // Verifica se o usuário já existe
    bool exists = await bancoDados.existsUser(email , password);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail já cadastrado!')),
      );
      return;
    }

    // Cria um novo objeto ListaCompra
    ListaCompra listaCompra = ListaCompra(
      descricao: '', // Adicione a descrição conforme necessário
      concluida: false, // Adicione o valor padrão para concluída
      categoria: Categoria.outra, // Adicione a categoria conforme necessário
      email: email,
      senha: password,
      nome: name,
    );

    try {
      bancoDados.create(listaCompra); // Cadastra a lista de compra no banco de dados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lista de compra cadastrada com sucesso!')),
      );
      Navigator.pop(context); // Redireciona para a tela anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar lista de compra: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu nome';
                }
                if (!RegExp(r'^[a-zA-ZÀ-ú-\s]+$').hasMatch(value!)) {
                  return 'Nome inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'E-mail inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  cadastrarUsuario(context); // Chama o método de cadastro
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
