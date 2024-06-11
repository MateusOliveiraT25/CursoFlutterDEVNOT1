import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Definição da classe Jogador
class Jogador {
  final String nome;
  final String posicao;
  final String urlImagem;
  Offset position; // Posição do jogador no campo

  Jogador(this.nome, this.posicao, this.urlImagem, {required this.position});
}

class MyApp extends StatefulWidget {// Classe principal do aplicativo
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Jogador> timeEsquerda = [
    Jogador('Manuel Neuer', 'Goleiro', 'https://imgs.search.brave.com/r6LASJRhw_S1TnwFAZxeM5sZJe_dE99PVOFO7pwRygY/rs:fit:500:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy8x/LzEwLzIwMTgwNjAy/X0ZJRkFfRnJpZW5k/bHlfTWF0Y2hfQXVz/dHJpYV92cy5fR2Vy/bWFueV9NYW51ZWxf/TmV1ZXJfODUwXzA3/MjMuanBn',
        position: Offset(150, 100)),
    Jogador('Cafu', 'Lateral-direito', 'https://imgs.search.brave.com/b46sLCugmiviWAHfEUqTBqwmcvgU6cntXRWdg_6CCtE/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNjYy/NTcxODQwL3Bob3Rv/L21hcmNvcy1jYWZ1/LWFjLW1pbGFuLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz04/NlY3amVIRmhza1Bj/ejlWc3dDYXZ0b3du/d0xNbXRseXM2QWh1/emVrcFlZPQ',
        position: Offset(250, 150)),
    Jogador('Franz Beckenbauer', 'Zagueiro', 'https://imgs.search.brave.com/V6rPSDUJM_6jaxr9jcuN6J-jmujCbhr1ZRjFT64B4yA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTE1/MTEyMDQ4L3B0L2Zv/dG8vZnJhbnotYmVj/a2VuYmF1ZXItbWVt/YmVyLW9mLXRoZS13/ZXN0LWdlcm1hbi1z/b2NjZXItdGVhbS13/aG8tbGF0ZXItc2ln/bmVkLWEtY29udHJh/Y3Qtd2l0aC10aGUu/anBnP3M9NjEyeDYx/MiZ3PTAmaz0yMCZj/PW1PallMeXE1Nzk2/Mk4xZklWOGNkemdo/RWlsNzVNZ1hRazda/a0o5cEFScUE9',
        position: Offset(150, 200)),
    Jogador('Paolo Maldini', 'Zagueiro', 'https://imgs.search.brave.com/6Z0l4fhgzXXAsK8aAl3-NJnqAoe-2FuIYN0ZCWTXwNU/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzZmL2Yw/LzM0LzZmZjAzNDAw/ODZmNmJhNWMyNjFk/ZDAxNjRkMGYzOGEx/LmpwZw',
        position: Offset(250, 200)),
    Jogador('Roberto Carlos', 'Lateral-esquerdo', 'https://imgs.search.brave.com/6bKKK_HpUbrzPFoMXjX4_r8mZ2XUV21y8R4be3USzUc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/YS50cmFuc2Zlcm1h/cmt0LnRlY2hub2xv/Z3kvcG9ydHJhaXQv/YmlnLzc1MTgtMTU5/NTMyMTgxNy5qcGc_/bG09MQ',
        position: Offset(150, 250)),
    Jogador('Zinedine Zidane', 'Meio-campista', 'https://imgs.search.brave.com/4CivWr2tBrwPCeXQy0d28S_93_m6J_HwWK5Il5l1Nv4/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTY0/MDE4Mi9waG90by9h/LXBvcnRyYWl0LW9m/LXppbmVkaW5lLXpp/ZGFuZS1vZi1qdXZl/bnR1cy10YWtlbi1k/dXJpbmctdGhlLWNs/dWItcGhvdG9jYWxs/LW1hbmRhdG9yeS1j/cmVkaXQuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPTdxUWsz/S2NfYnU3eGZLMTRB/NXVtU2RMVHdyNUlG/dzd2SVZ3RUxDdUFf/SUk9',
        position: Offset(250, 250)),
    Jogador('Diego Maradona', 'Meio-campista', 'https://imgs.search.brave.com/vJiruOSgT9OcaL1qXKyxo98JeEvsVcNJoLaeTn0cPsU/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM2/NTg0NzY5My9waG90/by9uYXBsZXMtaXRh/bHktc3NjLW5hcG9s/aS1wbGF5ZXItZGll/Z28tbWFyYWRvbmEt/cGljdHVyZWQtbG9v/a2luZy1vbi1kdXJp/bmctYS1zZXJpYS1h/LW1hdGNoLWluLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1K/akd1cHBuRDRFWDBm/SVRZSGZXblp1bklu/emxTUWM3VGRlSmV2/d2h3bWcwPQ',
        position: Offset(150, 300)),
    Jogador('Johan Cruyff', 'Atacante', 'https://imgs.search.brave.com/eJ61vAaPLibd3eW4PxkJg2i2qHElrjejQvcgsyUOmFA/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTIy/MTE5OTk1MC9waG90/by8xOTc3LTc4LWpv/aGFuLWNydWlqZmYt/b2YtYmFyY2Vsb25h/LWxvb2tzLW9uLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1x/SXJJNUpIOXJuWmk5/cGIwYWVYQUp3YnFa/RTh2cmJXbGVGY2I2/NjUycHFVPQ',
        position: Offset(250, 300)),
    Jogador('Pelé', 'Atacante', 'https://imgs.search.brave.com/z9tGSnjGh1QAgRAfve0WqS_Ha2oV1ie7hgGAXd3FGxc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy81/LzVlL1BlbGVfY29u/X2JyYXNpbF8oY3Jv/cHBlZCkuanBn',
        position: Offset(150, 350)),
    Jogador('Lionel Messi', 'Atacante', 'https://imgs.search.brave.com/3hHeTaw6l8m7DvE6mZOviRDM2CzkGCCiwwVtvrLMlGY/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pLnN1/cGVyZXNwb3J0ZXMu/Y29tLmJyL2poWVRZ/WWpLZmZzRy1Ic3hf/Sk5KUlRsUlVnZz0v/NjUweDAvc21hcnQv/aW1nc2FwcC5tZy5z/dXBlcmVzcG9ydGVz/LmNvbS5ici9hcHAv/bm90aWNpYV8xMjY0/MjAzNjA4MDgvMjAy/My8wNS8wNS8zOTk0/NDIxL21lc3NpLW5h/by1xdWVyLWVzcGVy/YXItYXRlLW8tdWx0/aW1vLWRpYS1kZS1q/YW5lbGEtcGFyYS1k/ZWZpbmlyLXNldS1m/dXR1cm8tYXBvcy1z/YWlkYS1kby1wc2df/MV80MzEyMy5qcGc',
        position: Offset(250, 350)),
    Jogador('Cristiano Ronaldo', 'Atacante', 'https://imgs.search.brave.com/tr9umnuFgIldX95wCgLzRkZFacEBZ2Wb0A8ZOIAB9js/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9mcGZp/bWFnZWhhbmRsZXIu/ZnBmLnB0L0ZQRklt/YWdlSGFuZGxlci5h/c2h4P3R5cGU9UGVy/c29uJmlkPTMwMjUy/MTcmb3A9dCZ3PTMy/NSZoPTM3OA',
        position: Offset(150, 400)),
  ];

  final List<Jogador> timeDireita = [
    Jogador('Gianluigi Buffon', 'Goleiro', 'https://imgs.search.brave.com/zUpsYLbT1HZJI7e0LXLSKxEsXZGdhmXKCDZy9DdpGEU/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zcG9y/dGJ1enoudW9sLmNv/bS5ici9tZWRpYS9f/dmVyc2lvbnMvZ2V0/dHlpbWFnZXMtMTE3/NDM2MTc4NV93aWRl/c20uanBn',
        position: Offset(600, 100)),
    Jogador('Dani Alves', 'Lateral-direito', 'https://imgs.search.brave.com/YB9NeDLz6oMolp2OQcgu779G2wNDi7XZXrMHIK9A5Mc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zb21v/c2ZhbmF0aWNvcy5m/YW5zL2JyL19uZXh0/L2ltYWdlP3VybD1o/dHRwczovL2Ntcy5z/b21vc2ZhbmF0aWNv/cy5jb20vX19leHBv/cnQvMTY1MTg1MDI4/MzI5OS9zaXRlcy9m/YW5hdGljb3MvaW1n/LzIwMjIvMDUvMDYv/Z2V0dHlpbWFnZXMt/MTM5MzgyNjE5OC5q/cGdfMTU0NjM5ODcy/Ny5qcGcmdz0zODQw/JnE9NzU.jpeg',
        position: Offset(500, 150)),
    Jogador('Fabio Cannavaro', 'Zagueiro', 'https://imgs.search.brave.com/3eLKqaJnfP2yNE55rxBkIm8vqR9Sil-vqTlnPfU0rlU/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9mYnJl/Zi5jb20vcmVxLzIw/MjMwMjAzMC9pbWFn/ZXMvaGVhZHNob3Rz/LzUxMTUyNTI3XzIw/MjIuanBn',
        position: Offset(600, 200)),
    Jogador('Sergio Ramos', 'Zagueiro', 'https://imgs.search.brave.com/xkCjDjYiU7sXDTTcxPq6ohrXg-Zg6hGmCdhQZ1DpanM/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/YS50cmFuc2Zlcm1h/cmt0LnRlY2hub2xv/Z3kvcG9ydHJhaXQv/YmlnLzI1NTU3LTE2/OTQ1MDI4MTIuanBn/P2xtPTE',
        position: Offset(500, 200)),
    Jogador('Marcelo', 'Lateral-esquerdo', 'https://imgs.search.brave.com/QZct4F3b8NmfLhc1cSiCsvhen6nYiAE-ZLydgQs4Das/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9mYnJl/Zi5jb20vcmVxLzIw/MjMwMjAzMC9pbWFn/ZXMvaGVhZHNob3Rz/LzYwMzExNmE3XzIw/MjIuanBn',
        position: Offset(600, 250)),
    Jogador('Michel Platini', 'Meio-campista', 'https://imgs.search.brave.com/Mkn618vfvfR5uT6_3SVw_foszOIgRZ3slUxUHL1Evgs/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTE1/MDI2MTgvcHQvZm90/by9zYWludC1sYW1i/ZXJ0LWRlcy1ib2lz/LWZyYW5jZS1wb3J0/cmFpdC1vZi1mcmVu/Y2gtY2FwdGFpbi1h/bmQtbWlkZmllbGRl/ci1taWNoZWwtcGxh/dGluaS10YWtlbi0y/Ni5qcGc_cz02MTJ4/NjEyJnc9MCZrPTIw/JmM9blRxN0pCREZp/MkFFVTlKN055UUxv/bmdnd2hYOGFBQjdq/WjlJOXYyMzhoMD0',
        position: Offset(500, 250)),
    Jogador('Xavi', 'Meio-campista', 'https://imgs.search.brave.com/ABrVCQUZT0P32mh7H1NDTe2o6PI92-CeQvDhem6p42E/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9mbWRh/dGFiYS5jb20vaW1h/Z2VzL3AvMjc0NDA2/LnBuZw',
        position: Offset(600, 300)),
    Jogador('Luka Modric', 'Meio-campista', 'https://imgs.search.brave.com/QJ3BFXRbYNkbCog_Y9i-_pdZX6siUZzejJ9FINWGzJc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/YS50cmFuc2Zlcm1h/cmt0LnRlY2hub2xv/Z3kvcG9ydHJhaXQv/YmlnLzI3OTkyLTE2/ODc3NzYxNjAuanBn/P2xtPTE',
        position: Offset(500, 300)),
    Jogador('Marco Van Basten', 'Atacante', 'https://imgs.search.brave.com/fiV7zaPbaaUOfVrBM-4cbgEPz9ugY6j3Li4APrZR9bo/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL00v/TVY1QlpqQXhZVEkz/T0dNdE9ETTVOaTAw/TTJNeExXRmxObU10/WW1JNE5qSXhZVFZs/T0RjMlhrRXlYa0Zx/Y0dkZVFYVnlNalV5/TkRrMk9EY0AuanBn',
        position: Offset(600, 350)),
    Jogador('Ronaldo', 'Atacante', 'https://imgs.search.brave.com/cFDFaRUTRIB52Hr6O7uopWc9uaVnRhmxPX5AQxYashI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG4u/YnJpdGFubmljYS5j/b20vNDgvMTQyODQ4/LTA1MC0yQTZGQzU2/OS9Sb25hbGRvLTIw/MDQuanBnP3c9NDAw/Jmg9MzAwJmM9Y3Jv/cA',
        position: Offset(500, 350)),
    Jogador('Ronaldinho', 'Atacante', 'https://imgs.search.brave.com/kFeSx0Xy-oQjeZsji3G53l-mSi1acldXTSsFjV8AZyg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL00v/TVY1Qk1tWmlPVGsx/Wm1JdE5qWTFOUzAw/T0RnMkxUa3hNR1F0/TVRnd1ltTmhOalU0/TURjNFhrRXlYa0Zx/Y0dkZVFYVnlNelEz/TnprNU1UVUAuanBn',
        position: Offset(600, 400)),
  ];

  Jogador? jogadorSelecionado;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Futebol'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Monte seu time'),
                Tab(text: 'História'),
                Tab(text: 'Regras'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Stack(
                children: [
                 Image.asset(
  'assets/campo_futebol.png',
  fit: BoxFit.contain,
  width: double.infinity,
  height: double.infinity,
),

            for (var jogador in timeEsquerda) // Posiciona os jogadores da esquerda
              Positioned(
                left: jogador.position.dx,
                top: jogador.position.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      jogador.position += details.delta;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(jogador.urlImagem),
                        radius: 20,
                      ),
                      SizedBox(height: 4),
                      Text(
                        jogador.nome,
                       style: TextStyle(color: Color.fromARGB(255, 171, 255, 111)),
                            ),
                    ],
                  ),
                ),
              ),
            for (var jogador in timeDireita) // Posiciona os jogadores da direita
              Positioned(
                left: jogador.position.dx,
                top: jogador.position.dy,
                child: GestureDetector(//para detectar o gesto de arrastar e mover os jogadores.
                //Para cada jogador, você criou um widget GestureDetector 
                  onPanUpdate: (details) {//você atualiza a posição do jogador  (jogador.position)
                   // adicionando a diferença entre a posição anterior e a nova posição do gesto (details.delta)
                    setState(() {// Ao chamar setState dentro do onPanUpdate, você informa ao Flutter que o estado do widget
                    // mudou e que ele deve reconstruir a interface para refletir essa mudança.
                      jogador.position += details.delta;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(jogador.urlImagem),
                        radius: 20,
                      ),
                      SizedBox(height: 4),
                      Text(
                        jogador.nome,
                           style: TextStyle(color: Color.fromARGB(255, 171, 255, 111)),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
             Center(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      'O futebol é um dos esportes mais populares do mundo, com uma história rica e diversificada. '
      'Originado na Inglaterra, o esporte se espalhou rapidamente por todo o mundo, tornando-se uma paixão global. '
      'Com regras simples e a capacidade de unir pessoas de diferentes culturas e origens, o futebol transcende barreiras e é um símbolo de união e competição saudável.',
      style: TextStyle(fontSize: 18),
    ),
  ),
),

              ListView(
                children: [
                  ListTile(
                    title: Text('Regra 1: O objetivo do jogo'),
                    subtitle: Text('O objetivo do futebol é marcar mais gols do que o adversário.'),
                  ),
                  ListTile(
                    title: Text('Regra 2: Duração da partida'),
                    subtitle: Text('Um jogo de futebol é dividido em dois tempos de 45 minutos cada, com um intervalo de 15 minutos.'),
                  ),
                  ListTile(
                    title: Text('Regra 3: Número de jogadores'),
                    subtitle: Text('Cada time de futebol é composto por 11 jogadores, incluindo um goleiro.'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
