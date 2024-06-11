import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Controller.dart';
import 'Model.dart';
import 'registroPage.dart';
import 'ConfiguracoesPage.dart';

// Tela de login
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: LoginForm(), // Exibe o formulário de login
      ),
    );
  }
}

// Formulário de login
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _loading = false; // Variável para controlar a exibição do indicador de carregamento

  // Função para realizar o login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String senha = _senhaController.text;

      setState(() {
        _loading = true; // Ativa o indicador de carregamento
      });

      BancoDadosCrud bancoDados = BancoDadosCrud();
      try {
        User? user = await bancoDados.getUser(email, senha);
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfiguracoesPage(email: user.email), // Navega para a página de configurações com o email do usuário
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Email ou senha incorretos'), // Exibe mensagem de erro se o usuário não for encontrado
          ));
        }
      } catch (e) {
        print('Erro durante o login: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro durante o login. Tente novamente mais tarde.'), // Exibe mensagem de erro genérica
        ));
      } finally {
        setState(() {
          _loading = false; // Desativa o indicador de carregamento
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  } else if (!isValidEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')), // Impede a entrada de números
                ],
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
              _loading
                  ? CircularProgressIndicator() // Indicador de carregamento enquanto o login é processado
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text('Acessar'),
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()), // Navega para a tela de cadastro
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para verificar se um email é válido
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

