import 'package:aula01_flutter/paginas/login.dart';
import 'package:aula01_flutter/servico/usuario.dart';
import 'package:flutter/material.dart';

class CriaEditaUsuario extends StatefulWidget {
  const CriaEditaUsuario({super.key});

  @override
  State<CriaEditaUsuario> createState() => _CriaEditaUsuarioState();
}

class _CriaEditaUsuarioState extends State<CriaEditaUsuario> {
  final _servicoUsuario = ServicoUsuario();
  final _nomeUsuario = TextEditingController();
  final _usuario = TextEditingController();
  final _role = TextEditingController();
  final _senha = TextEditingController();
  final _valSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _salvarUsuario() {
    print('-------------------->TESTE');
    if (!_formKey.currentState!.validate()) return;

    _servicoUsuario.cria(<String, String>{
      'name': _nomeUsuario.text,
      'username': _usuario.text,
      'role': _role.text,
      'password': _senha.text
    }).then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Usuário já cadastrado: ${_nomeUsuario.text}')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Salvo com sucesso')));
        Navigator.pop(context);
      }
    }).catchError((error) {

      print('-------------------->ERRO $error');
      print('-------------------->ERRO $_nomeUsuario.text');
      print('-------------------->ERRO $_usuario.text');
      print('-------------------->ERRO $_senha.text');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastra/Edita usuário'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                controller: _nomeUsuario,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nome é obrigatório.";
                  }
                  return null;
                },
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                ),
                controller: _usuario,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Usuário é obrigatório.";
                  }
                  return null;
                },
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Role',
                ),
                controller: _role,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira a role separada por virgula.";
                  }
                },
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                controller: _senha,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Senha é obrigatória.";
                  }
                  return null;
                },
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirme a senha',
                ),
                controller: _valSenha,
                validator: (value) {
                  if (_senha.text != value || value == null || value.isEmpty) {
                    return "Senha não confere.";
                  }
                  return null;
                },
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
              Padding(
                  padding: const EdgeInsets.all(36),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _salvarUsuario,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ))
            ]),
          ),
        ));
  }
}
