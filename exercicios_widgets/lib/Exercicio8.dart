import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: ListView(
        children: <Widget>[
          ProductCard(
            image: 'https://imgs.search.brave.com/pBjz-jzZFv--VAn2jryFkRRDuwogYA6QtLXOhYgJvsI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWdu/aWtlLWEuYWthbWFp/aGQubmV0LzE5MjB4/MTkyMC8wMTEyMjRJ/TUEyLmpwZw',
            title: 'Tênis Nike Air Max',
            description: 'Tênis esportivo de alta performance.',
          ),
          ProductCard(
            image: 'https://imgs.search.brave.com/mtnv_fV7xXsY21PKqMv4CQ7ZAAzTUWh41Eay2zIyUA4/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMubmV0c2hvZXMu/Y29tLmJyL3Byb2R1/dG9zL3RlbmlzLWFk/aWRhcy11bHRyYWJv/b3N0LWxpZ2h0LTIz/LzkzL0ZCOC00Mzcz/LTc5My9GQjgtNDM3/My03OTNfem9vbTEu/anBnP3RzPTE3MDA1/NzY0MzIm',
            title: 'Tênis Adidas Ultraboost',
            description: 'Tênis de corrida com tecnologia Boost.',
          ),
          ProductCard(
            image: 'https://imgs.search.brave.com/x15nkhPxvO05jg-sLO6UaBfVw1DSf5BGURN6QfF1Jd0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWdj/ZW50YXVyby1hLmFr/YW1haWhkLm5ldC8x/MzY2eDEzNjYvOTY2/MTExMlZBMS5qcGc',
            title: 'Tênis Asics Gel Nimbus',
            description: 'Tênis confortável para corridas longas.',
          ),
          // Adicione mais ProductCards conforme necessário
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: 200, // Defina a altura desejada aqui
            child: Image.network(
              image,
              fit: BoxFit.cover, // Ajuste a imagem para preencher o contêiner
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(description),
          ),
        ],
      ),
    );
  }
}
