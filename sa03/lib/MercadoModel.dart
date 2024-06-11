import 'categorias.dart'; // Correct import statement for accessing Categoria

class ListaCompra {
  String descricao;
  bool concluida;
  Categoria categoria;
  DateTime dataHora;
  int? id; // Make sure this matches the intended use (i.e., nullable or not)
  String email;
  String senha;
  String nome;

  // A more conventional Dart constructor, using named parameters where optional or potentially nullable
  ListaCompra({
    required this.descricao,
    required this.concluida,
    required this.categoria,
    DateTime? dataHora,
    this.id, // Now properly part of the constructor as an optional named parameter
    required this.email,
    required this.senha,
    required this.nome,
  }) : dataHora = dataHora ?? DateTime.now();

  // Convert ListaCompra instance to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'concluida': concluida,
      'categoria': categoria.toJson(), // Assuming Categoria has a toJson method
      'dataHora': dataHora.toIso8601String(),
      'id': id, // Optional, include if not null
      'email': email,
      'senha': senha,
      'nome': nome,
    };
  }

  // Convert a Map to a ListaCompra instance for JSON deserialization
  factory ListaCompra.fromJson(Map<String, dynamic> json) {
    return ListaCompra(
      descricao: json['descricao'],
      concluida: json['concluida'],
      categoria: CategoriaExtension.fromJson(json['categoria']),
      dataHora: DateTime.parse(json['dataHora']),
      id: json['id'], // Assuming it might be null
      email: json['email'],
      senha: json['senha'],
      nome: json['nome'],
    );
  }
}
