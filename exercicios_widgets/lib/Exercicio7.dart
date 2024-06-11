import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio(); // Chame o método _playAudio aqui
  }

void _playAudio() async {
  try {
    await audioPlayer.play('assets/audio.mp3', isLocal: true);
  } catch (e) {
    print('Erro ao reproduzir áudio: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Pop'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // Item do menu para mostrar as notícias sobre o Oscar
            ListTile(
              title: Text('Notícias sobre o Oscar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage(newsList: [
                    News('Oscar 2024: Lista completa dos vencedores', 'Confira todos os vencedores da noite mais importante do cinema.'),
                    News('Melhores looks do tapete vermelho do Oscar 2024', 'Veja os looks mais marcantes das celebridades no tapete vermelho do Oscar.'),
                    News('Surpresas e polêmicas do Oscar 2024', 'Confira as surpresas e polêmicas que marcaram a cerimônia do Oscar deste ano.'),
                  ])),
                );
              },
            ),
            // Item do menu para mostrar a notícia sobre música
            ListTile(
              title: Text('Notícia sobre música'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MusicNewsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        // Imagem de fundo para a tela inicial
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://imgs.search.brave.com/gVh9Tzw8zD8KP5nnG_6H8wiIHSV-SbAYJExdgOY9X60/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzljLzM4/L2ExLzljMzhhMWNh/NzFhNjhmNDVlYjBm/MjJkYzA4ZTg1ZTBh/LmpwZw'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// Página para exibir a notícia sobre música
class MusicNewsPage extends StatelessWidget {
  // Lista de notícias sobre música
  final List<News> musicNewsList = [
    News('Novo álbum da sua banda favorita é lançado', 'Ouça agora o novo álbum que está dando o que falar na cena musical.'),
    News('Artista famoso anuncia turnê mundial', 'Confira as datas da turnê do artista que está agitando o mundo da música.'),
    News('Música indicada ao Grammy se torna hit mundial', 'Ouça a música que está concorrendo ao prêmio de melhor do ano.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícia sobre música'),
      ),
      body: ListView.builder(
        itemCount: musicNewsList.length,
        itemBuilder: (context, index) {
          var news = musicNewsList[index];
          return ListTile(
            title: Text(news.title),
            subtitle: Text(news.description),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(news.title),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Página para exibir as notícias sobre o Oscar
class NewsPage extends StatelessWidget {
  final List<News> newsList;

  NewsPage({required this.newsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias sobre o Oscar'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          var news = newsList[index];
          return ListTile(
            title: Text(news.title),
            subtitle: Text(news.description),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(news.title),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Classe para representar uma notícia
class News {
  final String title;
  final String description;

  News(this.title, this.description);
}
