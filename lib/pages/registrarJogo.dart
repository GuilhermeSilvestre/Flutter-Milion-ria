import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:milionaria/pages/perfil.dart';

class RegistrarJogo extends StatefulWidget {
  const RegistrarJogo({Key? key}) : super(key: key);

  @override
  State<RegistrarJogo> createState() => _RegistrarJogoState();
}

class _RegistrarJogoState extends State<RegistrarJogo> {
  final _formKey = GlobalKey<FormState>();
  final _concursoController = TextEditingController();
  final _numerosController = List<TextEditingController>.generate(
    6,
    (index) => TextEditingController(),
  );
  final _numerosExtrasController = List<TextEditingController>.generate(
    2,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E3078), Colors.white],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _concursoController,
                  decoration: const InputDecoration(
                    labelText: 'Número do Concurso',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número do concurso';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Números de 1 a 50:',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                const SizedBox(height: 5.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 60.0,
                      child: TextFormField(
                        controller: _numerosController[index],
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.white),
                          labelText: 'Nº ${index + 1}',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um número';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Trevos de 1 a 6:',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                const SizedBox(height: 5.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: List.generate(
                    2,
                    (index) => SizedBox(
                      width: 60.0,
                      child: TextFormField(
                        controller: _numerosExtrasController[index],
                        decoration: InputDecoration(
                          labelText: 'Nº ${index + 1}',
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um número';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveJogo();
                    }
                  },
                  child: const Text('Registrar Jogo'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Perfil()),
                    );
                  },
                  child: const Text('Consultar jogos registrados'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveJogo() async {
    final Map<String, dynamic> jogoData = {
      'concurso': _concursoController.text,
      'numeros': _numerosController
          .map((controller) => int.parse(controller.text))
          .toList(),
      'numerosExtras': _numerosExtrasController
          .map((controller) => int.parse(controller.text))
          .toList(),
    };

    final File file = File('assets/jogosdousuario/jogosdousuario.json');
    List<Map<String, dynamic>> jogos = [];
    if (await file.exists()) {
      final String fileContent = await file.readAsString();
      jogos = json.decode(fileContent);
    }

    jogos.add(jogoData);
    await file.writeAsString(json.encode(jogos));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Jogo registrado com sucesso!'),
      ),
    );

    // Limpar campos após salvar
    _concursoController.clear();
    _numerosController.forEach((controller) => controller.clear());
    _numerosExtrasController.forEach((controller) => controller.clear());
  }
}
