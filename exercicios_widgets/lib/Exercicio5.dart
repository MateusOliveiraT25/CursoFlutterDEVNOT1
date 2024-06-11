import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Contato',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactForm(),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>(); // Chave global para identificar o formulário
  late String _name; // Variável para armazenar o nome
  late String _email; // Variável para armazenar o e-mail
  late String _message; // Variável para armazenar a mensagem

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Contato'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associar a chave global ao formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!; // Salvar o valor do campo nome
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!; // Salvar o valor do campo e-mail
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mensagem',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua mensagem';
                  }
                  return null;
                },
                onSaved: (value) {
                  _message = value!; // Salvar o valor do campo mensagem
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Validar o formulário
                      _formKey.currentState!.save(); // Salvar os campos do formulário
                      _submitForm(); // Chamar o método para enviar o formulário
                    }
                  },
                  child: Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Método para enviar os dados do formulário
    print('Nome: $_name');
    print('E-mail: $_email');
    print('Mensagem: $_message');
    // Aqui você pode enviar os dados para um servidor, por exemplo
  }
}
