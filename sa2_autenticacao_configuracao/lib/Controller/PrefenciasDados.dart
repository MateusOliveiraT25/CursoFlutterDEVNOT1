import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final String chaveCorTela = 'cor_tela';

  static Future<void> salvarCorTela(String cor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(chaveCorTela, cor);
  }

  static Future<String?> obterCorTela() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(chaveCorTela);
  }
  
}
