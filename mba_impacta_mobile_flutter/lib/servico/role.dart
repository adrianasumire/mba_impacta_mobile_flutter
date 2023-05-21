import 'dart:convert';
import 'dart:io';

import 'package:aula01_flutter/servico/sessao.dart';
import 'package:http/http.dart' as http;

class ServicoRole {
  final _baseUrl = "http://192.168.15.118:3000/roles";
  final _sessao = Sessao();

  Future<List<dynamic>> pegaListaRole() async {
    dynamic dadoLogado = await _sessao.pegaSessao();
    print('--------> Arq role.dart --> 1');
    print(dadoLogado);
    if (dadoLogado == null || dadoLogado['token'] == null)
      throw const HttpException("");
      print('--------> Arq role.dart --> 2');
    final token = dadoLogado['token'];
    final resposta = 
    await http.get(Uri.parse(_baseUrl), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    if (resposta.statusCode == 200) {
      print('--------> Arq role.dart --> 3');
      print(resposta.body);
      return List.from(jsonDecode(resposta.body));
    } else if (resposta.statusCode == 401) {
      print('--------> Arq role.dart --> 4');
      throw const HttpException("");
    }

    return [];
  }

  Future<dynamic> criaRole(dynamic user) async {
    dynamic dadoLogado = await _sessao.pegaSessao();
    if (dadoLogado == null || dadoLogado['token'] == null) {
      throw const HttpException("");
    }
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
