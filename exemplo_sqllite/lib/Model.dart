
class ContatoModel {
  int id;
  String nome;
  String email;
  String telefone;
  String endereco;

  // Constructor
  ContatoModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
  });


  //mapeamento
   Map<String, dynamic> toMap() {//atributo coluna
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
    };
  }

factory ContatoModel.fromMap(Map<String, dynamic> map) { // coluna atributo
    return ContatoModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      endereco: map['endereco'],
    );
  }

}
