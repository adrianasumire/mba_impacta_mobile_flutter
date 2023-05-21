import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class Sessao {
  final _armazenamento = LocalStorage('sessao.json');
  final _key = 'LOGGED_USER';

  Future<void> salvaSessao(dynamic user) async {
    bool isReady = await _armazenamento.ready;
    if (isReady) {
      await _armazenamento.setItem(_key, jsonEncode(user));
    }
  }

  Future<dynamic> pegaSessao() async {
    bool isReady = await _armazenamento.ready;
    if (isReady) {
      String json = await _armazenamento.getItem(_key);
      return jsonDecode(json);
    }
    return null;
  }

  Future<void> apagaSessao() async {
    bool isReady = await _armazenamento.ready;
    if (isReady) {
      return await _armazenamento.deleteItem(_key);
    }
  }
}
