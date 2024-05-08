import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AcertosJogo extends StatefulWidget {
  final String concurso;
  final List<dynamic> numeros;
  final List<dynamic> trevos;

  const AcertosJogo({
    super.key,
    required this.concurso,
    required this.numeros,
    required this.trevos,
  });

  @override
  State<AcertosJogo> createState() => _AcertosJogoState();
}

class _AcertosJogoState extends State<AcertosJogo> {
  late Future<Map<String, dynamic>> _concursoData;

  @override
  void initState() {
    super.initState();
    _concursoData = _fetchConcursoData();
  }

  Future<Map<String, dynamic>> _fetchConcursoData() async {
    final response = await http.get(Uri.parse(
        'https://loteriascaixa-api.herokuapp.com/api/maismilionaria/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        for (var concursoData in data) {
          if (concursoData['concurso'] == int.tryParse(widget.concurso)) {
            return concursoData;
          }
        }
        throw Exception('Concurso not found');
      } else {
        throw Exception('Data is empty');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget _buildNumberBall(String number,
      {bool isLastTwo = false, bool isGreen = false}) {
    // Adiciona um zero à esquerda se o número tiver apenas um dígito
    String formattedNumber = number.padLeft(2, '0');

    return Container(
      margin: const EdgeInsets.all(5),
      width: 33,
      height: 33,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isLastTwo ? Colors.green : (isGreen ? Colors.green : Colors.blue),
      ),
      child: Center(
        child: Text(
          formattedNumber,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3078),
        title: Text(
          'Acertos do Concurso ${widget.concurso}',
          style: const TextStyle(color: Colors.white),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Map<String, dynamic>>(
            future: _concursoData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return _buildErrorMessage(
                    'Não existe concurso com este número');
              } else {
                final concursoData = snapshot.data!;
                final numerosSorteados = concursoData['dezenasOrdemSorteio'];
                final numerosUsuario = widget.numeros;

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Concurso: ${concursoData['concurso']}',
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Data: ${concursoData['data']}',
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        'Números Sorteados:',
                        style: TextStyle(fontSize: 22, color: Colors.yellow),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Wrap(
                        children: [
                          for (var i = 0; i < numerosSorteados.length; i++)
                            _buildNumberBall(
                              numerosSorteados[i],
                              isLastTwo: i >= numerosSorteados.length - 2,
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Seus Números:',
                        style: TextStyle(fontSize: 22, color: Colors.yellow),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Wrap(
                        children: [
                          for (var numero in numerosUsuario)
                            _buildNumberBall(numero.toString()),
                          for (var trevo in widget.trevos)
                            _buildNumberBall(trevo.toString(), isLastTwo: true),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
