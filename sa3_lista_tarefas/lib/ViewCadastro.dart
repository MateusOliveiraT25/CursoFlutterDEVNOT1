import 'package:flutter/material.dart'; // Importando o pacote do Flutter

import 'DataBaseController.dart'; // Importando o controlador do banco de dados
import 'UserModel.dart'; // Importando o modelo de usuário

// Tela de cadastro de usuário
class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'), // Título da tela
      ),
      body: Center(
        child: CadastroForm(), // Exibindo o formulário de cadastro
      ),
    );
  }
}

// Formulário de cadastro
class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário
  TextEditingController _nomeController =
      TextEditingController(); // Controlador do campo de nome
  TextEditingController _emailController =
      TextEditingController(); // Controlador do campo de e-mail
  TextEditingController _senhaController =
      TextEditingController(); // Controlador do campo de senha

  // Método para cadastrar o usuário
  void cadastrarUsuario(BuildContext context) async {
    String name = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    User user = User(
        nome: name, email: email, senha: senha); // Criando um novo usuário

    BancoDadosCrud bancoDados =
        BancoDadosCrud(); // Instância do controlador do banco de dados
    try {
      // Verifica se o email já está cadastrado antes de criar o usuário
      bool emailCadastrado = await bancoDados.existsUser(email, senha);
      if (emailCadastrado) {
        // Exibe uma mensagem informando que o email já está cadastrado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'O email informado já está cadastrado. Por favor, insira um email diferente.')),
        );
      } else {
        // Se o email não estiver cadastrado, cria o usuário
        bancoDados.create(user);

        // Exibe uma mensagem de sucesso e redireciona para a tela de login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
        Navigator.pop(context); // Redireciona para a tela de login
      }
    } catch (e) {
      // Exibe uma mensagem de erro caso ocorra algum problema
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
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
              'Cadastro', // Título do formulário
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nomeController,
              decoration:
                  InputDecoration(labelText: 'Nome'), // Rótulo do campo de nome
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu nome'; // Validação do campo de nome
                }
                if (!RegExp(r'^[a-zA-ZÀ-ú-\s]+$').hasMatch(value!)) {
                  return 'Nome inválido'; // Validação do formato do nome
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'E-mail'), // Rótulo do campo de e-mail
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail'; // Validação do campo de e-mail
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'E-mail inválido'; // Validação do formato do e-mail
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(
                  labelText: 'Senha'), // Rótulo do campo de senha
              obscureText: true,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira sua senha'; // Validação do campo de senha
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  cadastrarUsuario(
                      context); // Chama a função para cadastrar o usuário
                }
              },
              child: Text('Cadastrar'), // Texto do botão de cadastro
            ),
          ],
        ),
      ),
    );
  }
}
