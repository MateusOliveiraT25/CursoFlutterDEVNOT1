class User {
  String name;
  String email;
  String senha;

  User({required this.name, required this.email, required this.senha});

  // Método para criar um usuário a partir de um mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  // Método para converter o usuário em um mapa
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'senha': senha,
    };
  }
}
