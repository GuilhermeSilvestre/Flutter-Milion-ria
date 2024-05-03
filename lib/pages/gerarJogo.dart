import 'package:flutter/material.dart';

class GerarJogo extends StatefulWidget {
  const GerarJogo({Key? key}) : super(key: key);

  @override
  State<GerarJogo> createState() => _GerarJogoState();
}

class _GerarJogoState extends State<GerarJogo> {
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
            'Conteúdo da página GERAR JOGO aqui',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
