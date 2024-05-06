import 'package:flutter/material.dart';
import 'package:milionaria/pages/gerarJogo.dart';
import 'package:milionaria/pages/perfil.dart';
import 'package:milionaria/pages/registrarJogo.dart';
import 'package:milionaria/pages/resultados.dart';
import 'package:milionaria/pages/sobre.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget _buildNavItem(IconData iconData, String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Colors.blue : Colors.grey;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.blue.withOpacity(0.3)
                    : Colors.transparent,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                iconData,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Resultados(),
    GerarJogo(),
    const RegistrarJogo(),
    const Perfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3078),
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/maismilionaria.png',
              height: 48,
              width: 48,
            ),
            const SizedBox(width: 5),
            const Text(
              "+Milionária",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Sobre()),
              );
            },
            icon: const Icon(Icons.view_headline_rounded, color: Colors.white),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.list, 'Resultados', 0),
              _buildNavItem(Icons.add, 'Gerar novo jogo', 1),
              _buildNavItem(Icons.save, 'Registrar Jogo', 2),
              _buildNavItem(Icons.person, 'Perfil', 3),
            ],
          ),
        ),
      ),
    );
  }
}
