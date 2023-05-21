import 'dart:convert';
import 'dart:io';

import 'package:aula01_flutter/servico/sessao.dart';
import 'package:http/http.dart' as http;

class ServicoUsuario {
  final _baseUrl = "http://192.168.15.118:3000/users";
  final _sessao = Sessao();

  Future<List<dynamic>> pegaLista() async {
    dynamic dadoLogado = await _sessao.pegaSessao();
    print('--------> Arq usuario.dart --> 1');
    if (dadoLogado == null || dadoLogado['token'] == null)
      throw const HttpException("");
    print('--------> Arq usuario.dart --> 2');
    final token = dadoLogado['token'];
    final resposta =
        await http.get(Uri.parse(_baseUrl), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    if (resposta.statusCode == 200) {
      print('--------> Arq usuario.dart --> 3');
      print(resposta.body);
      return List.from(jsonDecode(resposta.body));
    } else if (resposta.statusCode == 401) {
      print('--------> Arq usuario.dart --> 4');
      throw const HttpException("");
    }

    return [];
  }

  Future<dynamic> cria(dynamic user) async {
    dynamic dadoLogado = await _sessao.pegaSessao();
    if (dadoLogado == null || dadoLogado['token'] == null)
      throw const HttpException("");
    final token = dadoLogado['token'];

    final resposta = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode(user));

    if (resposta.statusCode == 201) {
      dynamic user = jsonDecode(resposta.body);
      _sessao.salvaSessao(user);
      return user;
    } else if (resposta.statusCode == 401) {
      throw const HttpException("");
    }

    return null;
  }
}
