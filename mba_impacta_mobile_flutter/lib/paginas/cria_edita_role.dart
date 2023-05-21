import 'package:aula01_flutter/paginas/login.dart';
import 'package:aula01_flutter/servico/role.dart';
import 'package:flutter/material.dart';

class CriaEditaRole extends StatefulWidget {
  const CriaEditaRole({super.key});

  @override
  State<CriaEditaRole> createState() => _CriaEditaRoleState();
}

class _CriaEditaRoleState extends State<CriaEditaRole> {
  @override
  final _nomeRole = TextEditingController();
  final _descricaoRole = TextEditingController();
  final _servicoRole = ServicoRole();
  final _formKey = GlobalKey<FormState>();

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    _servicoRole.criaRole(<String, String>{
      'name': _nomeRole.text,
      'description': _descricaoRole.text,
    }).then((value) {
      if (value == null) {
        print('--------------Role já cadastrada');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Role já cadastrada: ${_nomeRole.text}')));
      } else {
        print('--------------Salvo com sucesso');
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Salvo com sucesso')));
        Navigator.pop(context);
      }
    }).catchError((error) {
      print('--------------erro $error');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastra/Edita role'),
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
                  labelText: 'Nome da role',
                ),
                controller: _nomeRole,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nome da role é obrigatório.";
                  }
                  return null;
                },
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                controller: _descricaoRole,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Usuário é obrigatório.";
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
                      onPressed: _salvar,
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ))
            ]),
          ),
        ));
  }
}
