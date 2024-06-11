import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_json/Controller/carros_controller.dart';

import '../Model/carros_model.dart';

class CarroCadastroScreen extends StatefulWidget {
  const CarroCadastroScreen({super.key});

  @override
  State<CarroCadastroScreen> createState() => _CarroCadastroScreenState();
}

class _CarroCadastroScreenState extends State<CarroCadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _placaController = TextEditingController();
  TextEditingController _modeloController = TextEditingController();
  TextEditingController _marcaController = TextEditingController();
  TextEditingController _anoController = TextEditingController();
  TextEditingController _corController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  File? _imagemSelecionada;

  CarrosController _controller = CarrosController();
  @override
  void initState() {
    _controller.loadCarrosFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de carro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _placaController,
                    decoration: const InputDecoration(labelText: 'Placa'),
                    validator: (value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Placa não pode ser vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _modeloController,
                    decoration: const InputDecoration(labelText: 'Modelo'),
                    validator: (value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Modelo não pode ser vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _marcaController,
                    decoration: const InputDecoration(labelText: 'Marca'),
                    validator: (value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Marca não pode ser vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _anoController,
                    decoration: const InputDecoration(labelText: 'Ano'),
                    validator: (value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Ano não pode ser vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _corController,
                    decoration: const InputDecoration(labelText: 'Cor'),
                    validator: (value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Placa não pode ser vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Descrição não pode ser vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _valorController,
                    decoration: const InputDecoration(labelText: 'Valor'),
                    validator: (value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Valor não pode ser vazia';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _imagemSelecionada != null
                      ? Image.file(
                          _imagemSelecionada!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: _tirarFoto,
                    child: Text('Tirar Foto'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _cadastrarCarro();
                      }
                    },
                    child: Text("Cadastrar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  Carro criarObjeto() {
    return Carro(
      placa: _placaController.text,
      modelo: _modeloController.text,
      marca: _marcaController.text,
      ano: int.parse(_anoController.text),
      cor: _corController.text,
      descricao: _descricaoController.text,
      valor: double.parse(_valorController.text),
      foto: _imagemSelecionada!.path,
    );
  }

  void _limparValores() {
    _placaController.clear();
    _modeloController.clear();
    _marcaController.clear();
    _anoController.clear();
    _corController.clear();
    _descricaoController.clear();
    _valorController.clear();
    _imagemSelecionada = null;
  }

  void _apagarCampos() {
    _placaController.text = "";
    _modeloController.text = "";
    _marcaController.text = "";
    _anoController.text = "";
    _corController.text = "";
    _descricaoController.text = "";
    _valorController.text = "";
    _imagemSelecionada = null;
  }

void _cadastrarCarro() {
  // Verificar se a placa já existe
  if (_placaExiste()) {
    // Se a placa já existir, exibir uma mensagem de erro
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Placa já cadastrada. Por favor, insira uma placa diferente."),
      ),
    );
    return; // Sai do método se a placa já existe
  }
  
  // Cadastrar o carro
  _controller.addCarro(criarObjeto());
  // Salvar os carros
  _controller.saveCarrosToFile();
  // Limpar os campos
  _limparValores();
  _apagarCampos();

  // Exibir uma mensagem de sucesso
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Carro Cadastrado com Sucesso"),
    ),
  );
}

bool _placaExiste() {
  // Obter a placa do novo carro a ser cadastrado
  String novaPlaca = criarObjeto().placa;
  // Verificar se a placa já existe na lista de carros
  for (Carro carro in _controller.carroList) {
    if (carro.placa == novaPlaca) {
      return true; // Retorna verdadeiro se a placa já existir
    }
  }
  return false; // Retorna falso se a placa não existir
}
}