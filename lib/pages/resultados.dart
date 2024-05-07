import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:milionaria/pages/detalhesconcurso.dart';

class Concurso {
  final int numero;
  final String data;
  final List<String> numerosSorteados;
  final List<Map<String, dynamic>> premiacoes;

  Concurso({
    required this.numero,
    required this.data,
    required this.numerosSorteados,
    required this.premiacoes,
  });
}

class Resultados extends StatefulWidget {
  const Resultados({super.key});

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  // Dados do sorteio
  String loteria = '';
  int concurso = 0;
  String data = '';
  String local = '';
  List<String> dezenasOrdemSorteio = [];
  List<String> trevos = [];
  List<Map<String, dynamic>> premiacoes = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Método para buscar os dados do sorteio no endpoint
  Future<List<Concurso>> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://loteriascaixa-api.herokuapp.com/api/maismilionaria/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data.map((concursoData) {
          return Concurso(
            numero: concursoData['concurso'],
            data: concursoData['data'],
            numerosSorteados:
                List<String>.from(concursoData['dezenasOrdemSorteio']),
            premiacoes:
                List<Map<String, dynamic>>.from(concursoData['premiacoes']),
          );
        }).toList();
      } else {
        throw Exception('Data is empty');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Concurso>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final concursos = snapshot.data!;
            return ListView.builder(
              itemCount: concursos.length,
              itemBuilder: (context, index) {
                final concurso = concursos[index];
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetalheConcurso(concurso: concurso),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Concurso: ${concurso.numero}'),
                    subtitle: Text('Data: ${concurso.data}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Constrói um tile para exibir uma informação do sorteio
  Widget _buildInfoTile(String label, String value) {
    return ListTile(
      title: Text(
        label,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 234, 228, 228),
        ),
      ),
    );
  }

  // Constrói um tile para exibir os números sorteados
  Widget _buildNumbersTile(String label, List<String> numbers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: numbers.map((number) {
            // Verifica se o número é um trevo
            final isTrevo = trevos.contains(number);
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isTrevo ? Colors.green : Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                number,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

// Constrói a seção de premiações
  Widget _buildPrizes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Premiações',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        // Constrói cada item de premiação
        Column(
          children: premiacoes.map((premiacao) {
            return ListTile(
              title: Text(
                premiacao['descricao'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Ganhadores: ${premiacao['ganhadores']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                'R\$ ${premiacao['valorPremio']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
