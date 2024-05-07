import 'package:flutter/material.dart';
import 'package:milionaria/pages/resultados.dart';

class DetalheConcurso extends StatelessWidget {
  final Concurso concurso;

  DetalheConcurso({required this.concurso});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3078),
        title: Text(
          'Detalhes do Concurso ${concurso.numero}',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoTile('Concurso', '${concurso.numero}'),
              _buildInfoTile('Data', concurso.data),
              const SizedBox(height: 20),
              _buildNumbersTile('Números Sorteados', concurso.numerosSorteados),
              const SizedBox(height: 20),
              _buildPrizes(concurso.premiacoes),
            ],
          ),
        ),
      ),
    );
  }
}

// Constrói um tile para exibir uma informação do sorteio
Widget _buildInfoTile(String label, String value) {
  return ListTile(
    title: Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        children: numbers.asMap().entries.map((entry) {
          // Verifica se o número é um trevo
          final index = entry.key;
          final number = entry.value;
          Color backgroundColor = Colors.blue;
          if (index >= numbers.length - 2) {
            // Os últimos dois números
            backgroundColor = Colors.green;
          }
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
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
Widget _buildPrizes(List<Map<String, dynamic>> premiacoes) {
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
                color: Color.fromARGB(255, 143, 24, 125),
              ),
            ),
            subtitle: Text(
              'Ganhadores: ${premiacao['ganhadores']}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 43, 50, 15),
              ),
            ),
            trailing: Text(
              'R\$ ${premiacao['valorPremio']}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 40, 113, 35),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}
