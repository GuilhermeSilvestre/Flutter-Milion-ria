import 'package:flutter/material.dart';

class Resultados extends StatefulWidget {
  const Resultados({Key? key}) : super(key: key);

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
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
        child: const Center(
          child: Text(
            'Conteúdo da página RESULTADOS aqui',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
