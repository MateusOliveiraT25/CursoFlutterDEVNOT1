import 'package:app_carros/Controller.dart';
import 'package:app_carros/View.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
final CarroController controllerCarros = CarroController();
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Gerenciador de Carros',
theme: ThemeData(
primarySwatch: Colors.blue,
),
home: TelaListaCarro(controllerCarros),
);
}
}


