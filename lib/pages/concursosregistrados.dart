import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

class ConcursosRegistrados extends StatefulWidget {
  const ConcursosRegistrados({Key? key}) : super(key: key);

  @override
  State<ConcursosRegistrados> createState() => _ConcursosRegistradosState();
}

class _ConcursosRegistradosState extends State<ConcursosRegistrados> {
  List<Map<String, dynamic>> _jogos = [];

  @override
  void initState() {
    super.initState();
    _loadJogos();
  }

  Future<void> _loadJogos() async {
    try {
      final file = File('assets/jogosdousuario/jogosdousuario.json');
      if (await file.exists()) {
        final fileContent = await file.readAsString();
        setState(() {
          _jogos =
              (json.decode(fileContent) as List).cast<Map<String, dynamic>>();
        });
      }
    } catch (e) {
      print('Erro ao carregar jogos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3078),
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Text(
              "Jogos Registrados",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E3078), Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _jogos.isEmpty
                    ? const Text(
                        'Você ainda não possui jogos registrados.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    : Expanded(child: _buildJogosList()),
                Visibility(
                  visible: _jogos.isNotEmpty,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        final file =
                            File('assets/jogosdousuario/jogosdousuario.json');
                        if (await file.exists()) {
                          await file.delete();
                          setState(() {
                            _jogos = [];
                          });
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Jogos deletados!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color.fromARGB(
                                221, 223, 100, 83), // Cor de fundo
                          ),
                        );
                      },
                      child: const Text('Deletas todos registros'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJogosList() {
    return ListView.builder(
      itemCount: _jogos.length,
      itemBuilder: (context, index) {
        final jogo = _jogos[index];
        return Card(
          color: Colors.transparent,
          elevation: 0,
          child: ListTile(
            title: Text(
              'Concurso: ${jogo['concurso']}',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Row(
              children: [
                _buildNumeroBolas(jogo['numeros'], Colors.blue),
                const SizedBox(width: 10),
                _buildNumeroBolas(jogo['trevos'], Colors.green),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNumeroBolas(List<dynamic> numeros, Color cor) {
    return Row(
      children: numeros.map<Widget>((numero) {
        return Container(
          margin: const EdgeInsets.only(right: 5),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              numero.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }
}
