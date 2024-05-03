import 'package:flutter/material.dart';
import 'dart:math';

class GerarJogo extends StatefulWidget {
  @override
  _GerarJogoState createState() => _GerarJogoState();
}

class _GerarJogoState extends State<GerarJogo> {
  List<String> numerosAleatoriosDoisDigitos = [];
  List<String> numerosTrevosDoisDigitos = [];

  void gerarNumeros() {
    final random = Random();
    var numerosAleatorios = <int>{};
    var numerosTrevos = <int>{};

    // Gerar 6 números aleatórios de 1 a 50
    while (numerosAleatorios.length < 6) {
      numerosAleatorios.add(random.nextInt(50) + 1);
    }

    // Gerar 2 números aleatórios de 1 a 6
    while (numerosTrevos.length < 2) {
      numerosTrevos.add(random.nextInt(6) + 1);
    }

    // Convertendo para listas com dois dígitos
    numerosAleatoriosDoisDigitos = numerosAleatorios
        .map((numero) => numero.toString().padLeft(2, '0'))
        .toList();

    numerosTrevosDoisDigitos = numerosTrevos
        .map((numero) => numero.toString().padLeft(2, '0'))
        .toList();
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var numero in numerosAleatoriosDoisDigitos)
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Text(
                        numero,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var numero in numerosTrevosDoisDigitos)
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Text(
                        numero,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    gerarNumeros();
                  });
                },
                child: const Text('GERAR NOVO JOGO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GerarJogo(),
  ));
}
