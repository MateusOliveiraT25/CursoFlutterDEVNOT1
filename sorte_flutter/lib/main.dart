import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaJogo(),
    );
  }
}

class TelaJogo extends StatefulWidget {
  @override
  _TelaJogoState createState() => _TelaJogoState();
}
//atributos
class _TelaJogoState extends State<TelaJogo> {
  final _controller = TextEditingController();
  late int _numeroAleatorio;
  String _resultado = '';
  int _tentativas = 0;
  bool _mostrarBotaoVerificar = true;
  bool _mostrarBotaoTentarNovamente = false;

  @override
  void initState() {
    super.initState();
    _gerarNumeroAleatorio();
    // Adicionar listener para verificar a tecla "Enter"
    _controller.addListener(() {
      if (_controller.text.isNotEmpty && _controller.text.endsWith('\n')) {
        _verificarPalpite();
      }
    });
  }

  // Gera um número aleatório entre 0 e 100
  void _gerarNumeroAleatorio() {
    final random = Random();
    _numeroAleatorio = random.nextInt(100) + 1;
  }

 // Verifica se o palpite do usuário está correto e atualiza o resultado
void _verificarPalpite() {
  int? palpite = int.tryParse(_controller.text);
  if (palpite != null) {
    setState(() {
      _tentativas++;
      if (palpite == _numeroAleatorio) {
        _resultado = _gerarMensagemResultado();
        _mostrarBotaoVerificar = false;
        _mostrarBotaoTentarNovamente = true;
      } else if (palpite < _numeroAleatorio) {
        _resultado = 'Tente um número maior. Tentativa $_tentativas';
        _controller.clear(); // Limpa o campo de texto para o usuário digitar um novo palpite
      } else {
        _resultado = 'Tente um número menor. Tentativa $_tentativas';
        _controller.clear(); // Limpa o campo de texto para o usuário digitar um novo palpite
      }
    });
  }
}


  // Gera a mensagem de resultado com base no número de tentativas
  String _gerarMensagemResultado() {
    if (_tentativas <= 5) {
      return 'Parabéns! Você acertou em $_tentativas tentativas!';
    } else if (_tentativas <= 10) {
      return 'Parabéns! Você acertou em $_tentativas tentativas! Não desista!';
    } else {
      return 'Parabéns! Você acertou em $_tentativas tentativas! Talvez na próxima você acerte mais rápido.';
    }
  }

  // Reinicia o jogo
  void _reiniciarJogo() {
    setState(() {
      _gerarNumeroAleatorio();
      _resultado = '';
      _tentativas = 0;
      _mostrarBotaoVerificar = true;
      _mostrarBotaoTentarNovamente = false;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Adivinhação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tente adivinhar o número entre 1 e 100:'),
            SizedBox(height: 10),
            Container(
              width: 100,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                // Adicionar o listener para verificar a tecla "Enter"
                onSubmitted: (_) => _verificarPalpite(),
                // Adicionar o listener para verificar a tecla "Delete"
                onEditingComplete: _verificarTeclaDelete,
              ),
            ),
            SizedBox(height: 10),
            if (_mostrarBotaoVerificar)
              ElevatedButton(
                onPressed: _verificarPalpite,
                child: Text('Verificar'),
              ),
            if (_mostrarBotaoTentarNovamente)
              ElevatedButton(
                onPressed: _reiniciarJogo,
                child: Text('Tentar Novamente'),
              ),
            SizedBox(height: 10),
            Text(_resultado),
          ],
        ),
      ),
    );
  }

  // Verifica se a tecla pressionada é a tecla "Delete"
  void _verificarTeclaDelete() {
    final text = _controller.text;
    if (text.isEmpty) {
      _resultado = '';
      _mostrarBotaoTentarNovamente = false;
    }
    setState(() {});
  }
}
