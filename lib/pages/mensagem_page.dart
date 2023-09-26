import 'package:caronas_utfpr/controllers/login_controller.dart';
import 'package:caronas_utfpr/pages/home_page.dart';
import 'package:caronas_utfpr/pages/my_caronas_page.dart';
import 'package:flutter/material.dart';
import 'package:caronas_utfpr/repositories/mensagens_repository.dart';
import 'package:provider/provider.dart';
import 'chat_page.dart';

class MensagemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logado = Provider.of<LoginController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens'),
      ),
      body: ListView.builder(
        itemCount: MensagensRepository.mensagens.length,
        itemBuilder: (context, index) {
          final mensagem = MensagensRepository.mensagens[index];
          if (mensagem.remetente != logado.usuarioLogado) {
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(mensagem.remetente.fotoPerfil),
              ),
              title: Text(mensagem.remetente.nome),
              subtitle: Text(mensagem.mensagem),
              onTap: () {
                final mensagensDoRemetente = MensagensRepository.mensagens
                    .where((msg) => msg.remetente == mensagem.remetente)
                    .toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      mensagens: mensagensDoRemetente,
                      remetente: mensagem
                          .remetente.nome,
                    ),
                  ),
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
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
        currentIndex: 1,
        selectedItemColor: Colors.yellow.shade400,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomePage(),
              ),
            );
          }
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyCaronasPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
