import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://loteriascaixa-api.herokuapp.com/api/maismilionaria/'));
    if (response.statusCode == 200) {
      final List<dynamic> dados = json.decode(response.body);
      if (dados.isNotEmpty) {
        final primeiroConcurso = dados.first;
        setState(() {
          loteria = primeiroConcurso['loteria'];
          concurso = primeiroConcurso['concurso'];
          data = primeiroConcurso['data'];
          local = primeiroConcurso['local'];
          dezenasOrdemSorteio =
              List<String>.from(primeiroConcurso['dezenasOrdemSorteio']);
          trevos = List<String>.from(primeiroConcurso['trevos']);
          premiacoes =
              List<Map<String, dynamic>>.from(primeiroConcurso['premiacoes']);
        });
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
      body: loteria.isEmpty || premiacoes.isEmpty
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2E3078), Colors.white],
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2E3078), Colors.white],
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoTile('Concurso', '$concurso'),
                    _buildInfoTile('Data', data),
                    const SizedBox(height: 20),
                    _buildNumbersTile('Números Sorteados', dezenasOrdemSorteio),
                    const SizedBox(height: 20),
                    _buildPrizes(),
                  ],
                ),
              ),
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
