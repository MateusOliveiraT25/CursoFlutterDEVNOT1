import 'package:flutter/material.dart';

class AjudaSuportePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuda e Suporte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perguntas Frequentes:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FaqItem(
              pergunta: 'Como posso alterar minha senha?',
              resposta:
                  'Para alterar sua senha, vá para a página de perfil e clique em "Alterar Senha". Você será solicitado a digitar sua senha atual e a nova senha desejada.',
            ),
            FaqItem(
              pergunta: 'Como posso entrar em contato com o suporte?',
              resposta:
                  'Você pode entrar em contato com nosso suporte técnico por e-mail em suporte@mso.com ou ligando para o número (19) 987513026.',
            ),
            FaqItem(
              pergunta: 'O aplicativo está disponível em outros idiomas?',
              resposta:
                  'No momento, nosso aplicativo está disponível apenas em Português.',
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String pergunta;
  final String resposta;

  FaqItem({required this.pergunta, required this.resposta});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(pergunta),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(resposta),
        ),
      ],
    );
  }
}
