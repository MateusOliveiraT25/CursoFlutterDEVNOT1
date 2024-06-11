import 'package:flutter/material.dart';
import 'package:sa2_autenticacao_configuracao/Controller/Controller.dart';
import 'package:sa2_autenticacao_configuracao/View/acesso_login.dart';
import 'package:sa2_autenticacao_configuracao/View/Cadastro.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usuarioController =
      TextEditingController(); // Adicionando o controlador de usuário
  TextEditingController _senhaController =
      TextEditingController(); // Adicionando o controlador de senha

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
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usuarioController, // Usando o controlador de usuário
              decoration: InputDecoration(labelText: 'Usuário'),
              validator: (value) {
                if (value?.trim()?.isEmpty ?? true) {
                  return 'Por favor, insira seu usuário';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _senhaController, // Usando o controlador de senha
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value?.trim()?.isEmpty ?? true) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String email = _usuarioController.text;
                  String senha = _senhaController.text;

                  BancoDadosCrud bancoDados = BancoDadosCrud();

                  // Buscar o usuário no banco de dados
                  Map<String, dynamic>? usuario =
                      await bancoDados.buscarUsuario(email);

                  if (usuario != null && usuario['senha'] == senha) {
                    // Login bem-sucedido
                    String nome = usuario['nome'];
                    print('Login bem-sucedido para o usuário $nome');

                    // Navegar para a tela de acesso após o login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaAcesso(nome: nome)),
                    );
                  } else {
                    // Credenciais inválidas ou usuário não encontrado
                    print('Credenciais inválidas ou usuário não encontrado');
                  }
                }
              },
              child: Text('Acessar'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()),
                );
              },
              child: Text('Não tem uma conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
