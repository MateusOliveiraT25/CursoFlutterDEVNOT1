import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  final String email;

  ConfiguracoesPage({required this.email});

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState(email: email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences _prefs;
  bool _darkMode = false;
  final String email;
  String _idioma = 'pt-br';

  _ConfiguracoesPageState({required this.email});

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências do usuário ao iniciar a página
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // Carrega o tema escuro salvo (ou padrão se não existir)
      _darkMode = _prefs.getBool('${email}darkMode') ?? false;
      // Carrega o idioma selecionado salvo (ou padrão se não existir)
      _idioma = _prefs.getString('${email}SelIdioma') ?? 'pt-br';
    });
  }

  Future<void> _mudarDarkMode() async {
    setState(() {
      _darkMode = !_darkMode; // Alterna entre os modos escuro e claro
    });
    await _prefs.setBool('${email}darkMode', _darkMode); // Salva a preferência do tema
  }

  Future<void> _mudarIdioma(String idioma) async {
    setState(() {
      _idioma = idioma; // Altera o idioma selecionado
    });
    await _prefs.setString('${email}SelIdioma', _idioma); // Salva a preferência do idioma
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teste de Armazenamento Interno'),
        ),
        body: Center(
          child: Column(
            children: [
              Text("Selecione o Modo Escuro"),
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  _mudarDarkMode(); // Alterna o modo escuro ao interagir com o Switch
                },
              ),
              Text("Selecione o Idioma"),
              DropdownButton<String>(
                value: _idioma,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _mudarIdioma(newValue); // Altera o idioma ao selecionar uma opção no DropdownButton
                  }
                },
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'pt-br',
                    child: Text('Português (Brasil)'),
                  ),
                  DropdownMenuItem(
                    value: 'en-us',
                    child: Text('Inglês (EUA)'),
                  ),
                  DropdownMenuItem(
                    value: 'es-ar',
                    child: Text('Espanhol (Argentina)'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

