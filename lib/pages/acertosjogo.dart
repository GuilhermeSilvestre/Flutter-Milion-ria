import 'package:flutter/material.dart';

class AcertosJogo extends StatefulWidget {
  final String concurso;
  final List<dynamic> numeros;
  final List<dynamic> trevos;

  const AcertosJogo({
    Key? key,
    required this.concurso,
    required this.numeros,
    required this.trevos,
  }) : super(key: key);

  @override
  State<AcertosJogo> createState() => _AcertosJogoState();
}

class _AcertosJogoState extends State<AcertosJogo> {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Concurso: ${widget.concurso}'),
              Text('Números: ${widget.numeros.join(', ')}'),
              Text('Trevos: ${widget.trevos.join(', ')}'),
            ],
          ),
        ),
      ),
    );
  }
}
