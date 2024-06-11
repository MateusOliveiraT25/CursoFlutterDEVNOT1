import 'package:flutter/material.dart';
import 'MercadoController.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'categorias.dart'; // Importe o arquivo categorias.dart

class MercadoScreen extends StatefulWidget {
  @override
  _MercadoScreenState createState() => _MercadoScreenState();
}


class _MercadoScreenState extends State<MercadoScreen> {
  final TextEditingController _controllerDescricao = TextEditingController();
  Categoria? _categoriaSelecionada; // Categoria inicialmente vazia

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'), // Título da barra de aplicativo
      ),
      body: Consumer<ListaCompraController>( // Consumer para acessar o ListaCompraController
        builder: (context, model, child) {
          return Column(
            children: [
              // Botão para ordenar a lista por categoria
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
              // Campo de texto para a descrição do item
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controllerDescricao,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),
              ),
              // Dropdown para selecionar a categoria do item
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  value: _categoriaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      _categoriaSelecionada = value as Categoria?;
                    });
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
              // Botão para adicionar o item à lista
              ElevatedButton(
                onPressed: () {
                  String descricao = _controllerDescricao.text;
                  if (descricao.isNotEmpty && _categoriaSelecionada != null) {
                    if (!model.lista.any((item) =>
                        item.descricao.toLowerCase() == descricao.toLowerCase() &&
                        item.categoria == _categoriaSelecionada)) {
                      model.adicionarListaCompra(descricao, _categoriaSelecionada!);
                      _controllerDescricao.clear();
                      _categoriaSelecionada = null; // Reinicia a categoria selecionada para vazia
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('O produto já foi adicionado')),
                      );
                    }
                  }
                },
                child: Text('Adicionar à Lista'),
              ),
              // Lista de itens da lista de compras
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
                              // Checkbox para marcar como concluído
                              Checkbox(
                                value: lista.concluida,
                                onChanged: (value) {
                                  model.marcarComoConcluida(index);
                                },
                              ),
                              // Botão de edição
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _controllerDescricao.text = lista.descricao; // Preenche o campo de texto com a descrição atual
                                  setState(() {
                                    _categoriaSelecionada = lista.categoria; // Seleciona a categoria atual do item
                                  });
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
                                                setState(() {
                                                  _categoriaSelecionada = value as Categoria?;
                                                });
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
                                              Navigator.of(context).pop(); // Fecha o diálogo
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (_controllerDescricao.text.isNotEmpty && _categoriaSelecionada != null) {
                                                model.editarTarefa(index, _controllerDescricao.text, _categoriaSelecionada!);
                                                Navigator.of(context).pop(); // Fecha o diálogo
                                                _controllerDescricao.clear(); // Limpa o campo de texto
                                                _categoriaSelecionada = null; // Reinicia a categoria selecionada
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
                              // Ícone de exclusão
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  model.excluirListaCompra(index);
                                },
                              ),
                            ],
                          ),
                          onLongPress: () {
                            model.excluirListaCompra(index);
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
    );
  }
}