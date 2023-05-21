import 'dart:convert';
import 'dart:io';

import 'package:aula01_flutter/servico/sessao.dart';
import 'package:http/http.dart' as http;

class ServicoAutenticacao {
  final _baseUrl = 'http://192.168.15.118:3000/auth';
  final _sessao = Sessao();

  Future<dynamic> autentica(String usuario, String senha) async {
    final Uri urlCompleta = Uri.parse('$_baseUrl/login');
    final resposta = await http.post(Uri.parse('$urlCompleta'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
            <String, String>{'username': usuario, 'password': senha}));
    if (resposta.statusCode == 201) {
      dynamic user = jsonDecode(resposta.body);
      _sessao.salvaSessao(user);
      return user;
    }
    return null;
  }
}
