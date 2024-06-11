import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:sa03/MercadoModel.dart';
import 'MercadoController.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'categorias.dart';
import 'HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MercadoApp extends StatefulWidget {
  final String email;

  MercadoApp({required this.email});

  @override
  _MercadoAppState createState() => _MercadoAppState(email: email);
}

class _MercadoAppState extends State<MercadoApp> {
  late SharedPreferences _prefs;
  final String email;

  _MercadoAppState({required this.email});

  @override
  void initState() {
    super.initState();
    _loadController();
  }

Future<ListaCompraController> _loadController(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<ListaCompra> mercadoList = [];

  // Itera sobre as chaves e adiciona os itens de mercado à lista
  for (int i = 0; prefs.getString('${user.email}_item_$i') != null; i++) {
    mercadoList.add(ListaCompra.fromJson(jsonDecode(prefs.getString('${user.email}_item_$i')!)));
  }

  ListaCompraController controller = ListaCompraController(user, mercadoList);
  return controller;
}



 void _saveAndPop(ListaCompraController model, User user) {
  _saveController(model, user);
  Navigator.of(context).pop();
}

Future<void> _saveController(ListaCompraController controller, User user) async {
  // Remove todos os itens existentes antes de salvar os novos
  await _prefs.clear();

  // Salva cada item de mercado individualmente com uma chave única
  for (int i = 0; i < controller.lista.length; i++) {
    await _prefs.setString('${user.email}_item_$i', jsonEncode(controller.lista[i].toJson()));
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 250, 18, 215),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
        // Outras definições de cores
      ),
<<<<<<< HEAD
      home: FutureBuilder<ListaCompraController>(
        future: _loadController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider<ListaCompraController>.value(
              value: snapshot.data!,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Mercado'),
                  
                ),
=======
 home: FutureBuilder<ListaCompraController>(
  future: _loadController(User(email: widget.email, senha: '', nome: '')),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return ChangeNotifierProvider<ListaCompraController>.value(
        value: snapshot.data!,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Mercado'),
            leading:IconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: () {
    var model = Provider.of<ListaCompraController>(context, listen: false);
    var user = model.user;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    _saveAndPop(model, user);
  },
),

>>>>>>> 0e1d2799d375b94523f8684374b695bcd0a45520
                body: Consumer<ListaCompraController>(
                  builder: (context, model, child) {
                    final TextEditingController _controllerDescricao = TextEditingController();
                    Categoria? _categoriaSelecionada;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  model.ordenarPorCategoria();
                                },
                                child: Text('Ordenar por Categoria'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _controllerDescricao,
                            decoration: InputDecoration(
                              labelText: 'Descrição',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            value: _categoriaSelecionada,
                            onChanged: (value) {
                              _categoriaSelecionada = value as Categoria?;
                            },
                            items: Categoria.values.map((categoria) {
                              return DropdownMenuItem(
                                value: categoria,
                                child: Text(categoria.nome),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Categoria',
                            ),
                          ),
                        ),
                      ElevatedButton(
  onPressed: () {
    String descricao = _controllerDescricao.text;
    if (descricao.isNotEmpty && _categoriaSelecionada != null) {
      if (!model.lista.any((item) =>
          item.descricao.toLowerCase() == descricao.toLowerCase() &&
          item.categoria == _categoriaSelecionada)) {
        model.adicionarListaCompra(descricao, _categoriaSelecionada!);
        _controllerDescricao.clear();
        _categoriaSelecionada = null;
        _saveAndPop(model); // Salva e volta para a tela anterior
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('O produto já foi adicionado')),
        );
      }
    }
  },
  child: Text('Adicionar à Lista'),
),


                        Expanded(
                          child: ListView.builder(
                            itemCount: model.lista.length,
                            itemBuilder: (context, index) {
                              var lista = model.lista[index];
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        '${lista.descricao} - ${DateFormat('dd/MM/yyyy HH:mm').format(lista.dataHora)}'),
                                    subtitle: Text('Categoria: ${lista.categoria.nome}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(
                                          value: lista.concluida,
                                          onChanged: (value) {
                                            model.marcarComoConcluida(index);
                                            _saveController(model);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _controllerDescricao.text = lista.descricao;
                                            _categoriaSelecionada = lista.categoria;
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Editar Item'),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller: _controllerDescricao,
                                                        decoration: InputDecoration(
                                                          labelText: 'Nova Descrição',
                                                        ),
                                                      ),
                                                      DropdownButtonFormField(
                                                        value: _categoriaSelecionada,
                                                        onChanged: (value) {
                                                          _categoriaSelecionada = value as Categoria?;
                                                        },
                                                        items: Categoria.values.map((categoria) {
                                                          return DropdownMenuItem(
                                                            value: categoria,
                                                            child: Text(categoria.nome),
                                                          );
                                                        }).toList(),
                                                        decoration: InputDecoration(
                                                          labelText: 'Nova Categoria',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        if (_controllerDescricao.text.isNotEmpty && _categoriaSelecionada != null) {
                                                          model.editarListaCompra(index, _controllerDescricao.text, _categoriaSelecionada!);
                                                          Navigator.of(context).pop();
                                                          _controllerDescricao.clear();
                                                          _categoriaSelecionada = null;
                                                          _saveController(model);
                                                        }
                                                      },
                                                      child: Text('Salvar'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            model.excluirListaCompra(index);
                                            _saveController(model);
                                          },
                                        ),
                                      ],
                                    ),
                                    onLongPress: () {
                                      model.excluirListaCompra(index);
                                      _saveController(model);
                                    },
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
<<<<<<< HEAD
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  



}
=======
       } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  },
),
>>>>>>> 0e1d2799d375b94523f8684374b695bcd0a45520
