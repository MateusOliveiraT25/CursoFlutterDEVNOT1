import 'package:flutter/material.dart';
import 'package:sa2_autenticacao_configuracao/Controller/Controller.dart';
import 'package:sa2_autenticacao_configuracao/View/Home.dart';

void main() {
  runApp(MaterialApp(
    home: CadastroScreen(),
  ));
}

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

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}
class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

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
                if (value?.trim()?.isEmpty ?? true) {
                  return 'Por favor, insira seu nome';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value?.trim()?.isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail';
                }
                // Adicione validação de e-mail aqui se necessário
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value?.trim()?.isEmpty ?? true) {
                  return 'Por favor, insira sua senha';
                }
                // Adicione validação de senha aqui se necessário
                return null;
              },
            ),
            SizedBox(height: 20),
      ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      String nome = _nomeController.text;
      String email = _emailController.text;
      String senha = _senhaController.text;

      BancoDadosCrud bancoDados = BancoDadosCrud();
      
      // Salvando os dados de cadastro no banco de dados
      await bancoDados.cadastrarUsuario(nome, email, senha);
      
      // Exibir uma mensagem ou realizar outra ação após o cadastro
      print('Usuário cadastrado com sucesso!');

      // Navegar para a tela de login após o cadastro
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
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

