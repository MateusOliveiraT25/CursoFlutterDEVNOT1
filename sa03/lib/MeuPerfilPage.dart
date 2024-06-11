import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeuPerfilPage extends StatefulWidget {
  final String email;

  MeuPerfilPage({required this.email});

  @override
  _MeuPerfilPageState createState() => _MeuPerfilPageState(email: email);
}

class _MeuPerfilPageState extends State<MeuPerfilPage> {
  late SharedPreferences _prefs;
  final String email;
  String _nome = '';

  _MeuPerfilPageState({required this.email});

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = _prefs.getString('${email}Nome') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20),
            Text(
              _nome,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Email: $email'),
            SizedBox(height: 20),
           ElevatedButton(
  onPressed: () async {
    // Limpar os dados de login armazenados
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('senha');

    // Navegar de volta para a tela de login
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  },
  child: Text('Sair'),
),

          ],
        ),
      ),
    );
  }
}
