import 'package:aula01_flutter/paginas/cria_edita_usuario.dart';
import 'package:aula01_flutter/paginas/lista_roles.dart';
import 'package:aula01_flutter/paginas/login.dart';
import 'package:aula01_flutter/servico/usuario.dart';
import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  const Usuario({super.key});

  @override
  State<Usuario> createState() => _UsuarioState();
}

Future<List<dynamic>> _buscaUsuarios(BuildContext context) async {
  try {
    final lservicoUsuario = ServicoUsuario();
    return await lservicoUsuario.pegaLista();
  } catch (e) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Usuario()));
  }
  return [];
}

class _UsuarioState extends State<Usuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'Adiciona usuário',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CriaEditaUsuario()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.lock_person),
            tooltip: 'Lista roles',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Roles()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Desconectar',
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Login()));
            },
          )
        ],
      ),
      body: _criaLista(context),
    );
  }

  Widget _criaLista(BuildContext context) {
    return FutureBuilder(
      future: _buscaUsuarios(context),
      builder: (context, snapshot) {
        List<dynamic> listaUsuarios = snapshot.data ?? [];
        return ListView.builder(
            itemCount: listaUsuarios.length,
            itemBuilder: (context, index) {
              final usuario = listaUsuarios[index];
              return ListTile(
                title: Text(usuario['name']),
                subtitle: Text(usuario['username']),
              );
            });
      },
    );
  }
}
