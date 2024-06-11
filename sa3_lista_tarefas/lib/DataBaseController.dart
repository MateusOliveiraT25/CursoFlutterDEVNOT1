import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sa3_lista_tarefas/UserModel.dart';

// Classe para lidar com operações CRUD no banco de dados
class BancoDadosCrud {
  // Definindo o nome do banco de dados e o nome da tabela
  static const String DB_NOME = 'users.db';
  static const String TABLE_NOME = 'users';

  // Script para criar a tabela se ela não existir
  static const String SCRIPT_CRIACAO_TABELA =
      "CREATE TABLE IF NOT EXISTS $TABLE_NOME("
      "email TEXT PRIMARY KEY UNIQUE,"
      "nome TEXT,"
      "senha TEXT)";

  // Método para abrir o banco de dados
  Future<Database> _chamarBanco() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME),
      onCreate: (db, version) {
        // Executar o script de criação da tabela quando o banco de dados for criado pela primeira vez
        return db.execute(SCRIPT_CRIACAO_TABELA);
      },
      version: 1, // Versão do banco de dados
    );
  }

  // Método para adicionar um novo usuário ao banco de dados
  Future<void> create(User user) async {
    try {
      final Database db = await _chamarBanco();
      // Verificar se o usuário já existe no banco de dados
      List<Map<String, dynamic>> result = await db
          .query(TABLE_NOME, where: 'email = ?', whereArgs: [user.email]);
      if (result.isEmpty) {
        // Se o usuário não existir, inseri-lo no banco de dados
        await db.insert(TABLE_NOME, user.toMap());
      } else {
        // Se o usuário já existir, lançar uma exceção
        throw Exception('O email já está cadastrado.');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Erro ao criar usuário: $ex');
    }
  }

  // Método para obter um usuário do banco de dados com base no email e na senha fornecidos
  Future<User?> getUser(String email, String senha) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NOME,
          where: 'email = ? AND senha = ?', whereArgs: [email, senha]);

      if (maps.isNotEmpty) {
        // Se encontrar um usuário com as credenciais fornecidas, retorná-lo como um objeto User
        return User.fromMap(maps.first);
      } else {
        // Se não encontrar nenhum usuário, retornar null
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Método para verificar se um usuário com o email fornecido existe no banco de dados
  Future<bool> existsUser(String email, [String? senha]) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME, where: 'email = ?', whereArgs: [email]);

      // Verificar se a lista de resultados não está vazia
      return maps.isNotEmpty;
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}
