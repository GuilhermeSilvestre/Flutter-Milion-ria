import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:milionaria/pages/concursosregistrados.dart';
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
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
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
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
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
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
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
                      MaterialPageRoute(
                          builder: (context) => const ConcursosRegistrados()),
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
      'trevos': _numerosExtrasController
          .map((controller) => int.parse(controller.text))
          .toList(),
    };

    final File file = File('assets/jogosdousuario/jogosdousuario.json');
    List<Map<String, dynamic>> jogos = [];

    //Verifica se o arquivo existe e se contém dados válidos
    if (await file.exists()) {
      final String fileContent = await file.readAsString();
      if (fileContent.isNotEmpty) {
        // Se o arquivo não estiver vazio, decodifica seu conteúdo
        jogos = List<Map<String, dynamic>>.from(json.decode(fileContent));
      }
    }

    // Adiciona o jogoData à lista de jogos
    jogos.add(jogoData);

    // Sobrescreve o arquivo com a lista atualizada de jogos
    await file.writeAsString(json.encode(jogos));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Jogo registrado com sucesso!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(221, 127, 161, 190), // Cor de fundo
      ),
    );

    // Limpar campos após salvar
    _concursoController.clear();
    _numerosController.forEach((controller) => controller.clear());
    _numerosExtrasController.forEach((controller) => controller.clear());
  }
}
