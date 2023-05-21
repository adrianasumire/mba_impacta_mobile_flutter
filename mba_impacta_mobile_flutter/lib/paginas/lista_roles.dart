import 'package:aula01_flutter/paginas/cria_edita_role.dart';
import 'package:aula01_flutter/paginas/login.dart';
import 'package:aula01_flutter/servico/role.dart';
import 'package:flutter/material.dart';

class Roles extends StatefulWidget {
  const Roles({super.key});

  @override
  State<Roles> createState() => _RolesState();
}

Future<List<dynamic>> _buscaRoles(BuildContext context) async {
  try {
    final lservicoRoles = ServicoRole();
    return await lservicoRoles.pegaListaRole();
  } catch (e) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Roles()));
  }
  return [];
}

class _RolesState extends State<Roles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de roles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_moderator),
            tooltip: 'Adiciona role',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CriaEditaRole()));
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
      future: _buscaRoles(context),
      builder: (context, snapshot) {
        List<dynamic> listaRoless = snapshot.data ?? [];
        return ListView.builder(
            itemCount: listaRoless.length,
            itemBuilder: (context, index) {
              final Roles = listaRoless[index];
              return ListTile(
                title: Text(Roles['name']),
                subtitle: Text(Roles['description']),
              );
            });
      },
    );
  }
}
