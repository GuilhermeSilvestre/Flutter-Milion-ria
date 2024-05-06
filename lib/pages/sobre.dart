import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

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
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Este App foi feito para os apostadores das Loterias da Caixa Econômica Federal.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'O aplicativo te ajuda a registrar seus jogos da loteria +Milionária para ter mais controle sobre suas apostas.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'Além disso a aplicação exibe os resultados atualizados dos sorteios para você ficar informado, e também gera palpites de apostas caso queira utilizá-los.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 28,
                ),
                Text(
                  'Lembre-se: Este aplicativo não é governamental.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 58,
                ),
                Text(
                  'Boa sorte!',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
