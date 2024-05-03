import 'package:flutter/material.dart';

class RegistrarJogo extends StatefulWidget {
  const RegistrarJogo({Key? key}) : super(key: key);

  @override
  State<RegistrarJogo> createState() => _RegistrarJogoState();
}

class _RegistrarJogoState extends State<RegistrarJogo> {
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
            'Conteúdo da página REGISTRAR JOGO aqui',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
