import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importando para utilizar FilteringTextInputFormatter
import 'package:sa3_lista_tarefas/DataBaseController.dart'; // Importando o controlador do banco de dados
import 'package:sa3_lista_tarefas/UserModel.dart'; // Importando o modelo de usuário
import 'package:sa3_lista_tarefas/ViewCadastro.dart'; // Importando a tela de cadastro
import 'package:sa3_lista_tarefas/ViewListaTarefas.dart'; // Importando a tela da lista de tarefas

// Tela de login
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: LoginForm(), // Exibindo o formulário de login
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
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário
  TextEditingController _emailController =
      TextEditingController(); // Controlador do campo de e-mail
  TextEditingController _senhaController =
      TextEditingController(); // Controlador do campo de senha
  bool _loading = false; // Variável para controlar o estado de carregamento

  // Método para realizar o login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Verifica se o formulário é válido
      String email = _emailController.text;
      String senha = _senhaController.text;

      setState(() {
        _loading = true; // Ativa o estado de carregamento
      });

      BancoDadosCrud bancoDados =
          BancoDadosCrud(); // Instância do controlador do banco de dados
      try {
        bool isUserRegistered = await bancoDados.existsUser(
            email, senha); // Verifica se o usuário está cadastrado
        if (isUserRegistered) {
          User? user = await bancoDados.getUser(
              email, senha); // Obtém o usuário do banco de dados
          if (user != null) {
            Navigator.pushReplacement(
              // Navega para a tela da lista de tarefas
              context,
              MaterialPageRoute(
                builder: (context) => ListaTarefaPage(email: user.email),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Email ou senha incorretos'), // Exibe uma mensagem de erro
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Email não cadastrado. Por favor, cadastre-se.'), // Exibe uma mensagem para o usuário se cadastrar
          ));
        }
      } catch (e) {
        print('Erro durante o login: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Erro durante o login. Tente novamente mais tarde.'), // Exibe uma mensagem de erro genérica
        ));
      } finally {
        setState(() {
          _loading = false; // Desativa o estado de carregamento
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
                  return 'Por favor, insira seu e-mail'; // Validação do campo de e-mail
                } else if (!isValidEmail(value)) {
                  return 'E-mail inválido'; // Validação do formato do e-mail
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                    RegExp(r'[0-9]')), // Filtragem de caracteres
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira sua senha'; // Validação do campo de senha
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator() // Exibição de um indicador de carregamento
                : ElevatedButton(
                    onPressed:
                        _login, // Função chamada ao pressionar o botão de login
                    child: Text('Acessar'),
                  ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CadastroScreen()), // Navega para a tela de cadastro
                );
              },
              child: Text('Não tem uma conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }

  // Função para validar o formato do e-mail
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
