import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sa03/MercadoModel.dart'; // Importa o modelo de usuário

class BancoDadosCrud {
  static const String DB_NOME = 'listas_compras.db'; // Updated database name
  static const String TABLE_NOME = 'listas'; // Updated table name
  static const String SCRIPT_CRIACAO_TABELA = 
      "CREATE TABLE IF NOT EXISTS listas (" +
      "id INTEGER PRIMARY KEY," +
      "descricao TEXT, " +
      "concluida INTEGER, " + // Storing booleans as integers (0 or 1)
      "categoria TEXT, " + // Assuming categoria is stored as a JSON string
      "dataHora TEXT, " + // Dates stored as ISO8601 strings
      "email TEXT, " +
      "senha TEXT, " +
      "nome TEXT)";

  // Method to open the database
  Future<Database> _chamarBanco() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME),
      onCreate: (db, version) {
        return db.execute(SCRIPT_CRIACAO_TABELA);
      },
      version: 1,
    );
  }

  // Method to insert a new ListaCompra into the database
  Future<void> create(ListaCompra listaCompra) async {
    try {
      final Database db = await _chamarBanco();
      await db.insert(TABLE_NOME, listaCompra.toJson()); // Using toJson method to store the data
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Method to retrieve a ListaCompra by its unique ID
  Future<ListaCompra?> getListaCompra(int id, String senha) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NOME,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ListaCompra.fromJson(maps.first);
      } else {
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Method to check if a ListaCompra exists by ID
Future<bool> existsUser(String email, String password) async {
  try {
    final Database db = await _chamarBanco();
    final List<Map<String, dynamic>> maps = await db.query(
      TABLE_NOME,
      where: 'email = ? AND senha = ?',
      whereArgs: [email, password],
    );

    return maps.isNotEmpty;
  } catch (ex) {
    print(ex);
    return false;
  }
}


}