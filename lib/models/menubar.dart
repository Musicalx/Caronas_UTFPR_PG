import 'package:caronas_utfpr/pages/home_page.dart';
import 'package:caronas_utfpr/pages/mensagem_page.dart';
import 'package:caronas_utfpr/pages/my_caronas_page.dart';
import 'package:flutter/material.dart';

//------------------------Classe ainda não utilizada !----------------------------

class Menubar1 extends StatelessWidget {
  const Menubar1({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Mensagens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_filled),
            label: 'Minhas Caronas',
          ),
        ],
        selectedItemColor: Colors.yellow.shade400,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MensagemPage(),
              ),
            );
          }
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyCaronasPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
