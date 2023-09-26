import 'package:caronas_utfpr/controllers/login_controller.dart';
import 'package:caronas_utfpr/pages/cadastrarVeiculo_page.dart';
import 'package:caronas_utfpr/pages/mensagem_page.dart';
import 'package:caronas_utfpr/pages/my_caronas_page.dart';
import 'package:caronas_utfpr/pages/perfil_page.dart';
import 'package:caronas_utfpr/repositories/carona_repository.dart';
import 'package:flutter/material.dart';
import 'package:caronas_utfpr/pages/carona_page.dart';
import 'package:caronas_utfpr/pages/novaCarona_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sentido = true;

  @override
  Widget build(BuildContext context) {
    final tabela = CaronaRepository.tabela;
    final logado = Provider.of<LoginController>(context);
    bool home = tabela.any((carona) =>
        (carona.condutor.ra != logado.usuarioLogado.ra) &&
        carona.sentidoUtf == sentido &&
        !carona.finalizado &&
        carona.vagas > 0);

    /*print(logado.usuarioLogado.nome);
    print(logado.logado);
    print(logado.usuarioLogado.veiculo?.modelo);*/

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
            titleSpacing: 0.0,
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PerfilPage(),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage(logado.usuarioLogado.fotoPerfil),
                    ),
                  ),
                  SizedBox(width: 8),
                  if (sentido) Text('Sentido UTFPR') else Text('Saída UTFPR')
                ],
              ),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 30.0),
                icon: Icon(Icons.compare_arrows_rounded),
                onPressed: () {
                  setState(() {
                    sentido = !sentido;
                  });
                },
              ),
            ]),
      ),
      body: home
          ? ListView.separated(
              itemBuilder: (BuildContext context, int carona) {
                if (tabela[carona].condutor.ra != logado.usuarioLogado.ra &&
                    tabela[carona].sentidoUtf == sentido &&
                    !tabela[carona].finalizado &&
                    tabela[carona].vagas > 0) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage(tabela[carona].condutor.fotoPerfil),
                      ),
                      title: Text(tabela[carona].local),
                      subtitle: Text(
                          'Dia: ${tabela[carona].dia}\nHora: ${tabela[carona].hora}\nPreço: R\$ ${tabela[carona].preco}\nVagas: ${tabela[carona].vagas}'),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.yellow,
                            width: 2,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CaronaPage(
                                    carona: tabela[carona],
                                    caronaIndex: carona),
                              ),
                            );
                          },
                          child: Text(
                            'Reservar',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
              padding: const EdgeInsets.all(10),
              separatorBuilder: (_, ____) => Container(height: 0),
              itemCount: tabela.length,
            )
          : Center(
              child: Text("Nenhuma carona encontrada."),
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
        currentIndex: 0,
        selectedItemColor: Colors.yellow.shade400,
        onTap: (index) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (logado.usuarioLogado.veiculo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NovaCaronaPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastrarVeiculoPage(),
              ),
            );
          }
        },
        tooltip: 'Nova Carona',
        backgroundColor: Colors.yellow.shade400,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomSheet: const SizedBox(height: 50),
    );
  }
}
