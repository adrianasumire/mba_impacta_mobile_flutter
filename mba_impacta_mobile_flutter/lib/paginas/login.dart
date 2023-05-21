import 'package:aula01_flutter/paginas/lista_usuarios.dart';
import 'package:aula01_flutter/servico/autentica.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _servicoAutenticacao = ServicoAutenticacao();

  late String _usuario;
  late String _senha;

  /* Se fosse forçar login, fazendo a validacao sem backend
  void _signIn() {
    if (_usuario == 'adriana' && _senha == '123') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Usuario()));*/
  Future<void> _signIn() async {
    dynamic user = await _servicoAutenticacao.autentica(_usuario, _senha);
    if (user != null && user['token'] != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Usuario()));
    } else {
      /* Mostra a caixa preta de mensagem
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text('Usuário/Senha inválido(s)'));
      });*/
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Usuário/Senha inválido(s)')));
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              labelText: 'Usuário',
            ),
            onChanged: (value) {
              setState(() {
                _usuario = value;
              });
            },
          ),
          TextFormField(
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
            onChanged: (value) {
              setState(() {
                _senha = value;
              });
            },
          ),
          Padding(
              padding: const EdgeInsets.all(36),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _signIn,
                  icon: const Icon(Icons.login),
                  label: const Text('Login'),
                ),
              ))
        ]),
      ),
    );
  }
}
