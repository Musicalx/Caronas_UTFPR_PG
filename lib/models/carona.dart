import 'package:caronas_utfpr/models/usuario.dart';

class Carona {
  Usuario condutor;
  List<Usuario> passageiros = [];
  String local;
  int vagas;
  double preco;
  String dia;
  String hora;
  bool sentidoUtf;
  bool finalizado = false;

  Carona({
    required this.condutor,
    required this.local,
    required this.vagas,
    required this.preco,
    required this.dia,
    required this.hora,
    required this.sentidoUtf,
  });

  void adicionarPassageiro(Usuario passageiro) {
    if (passageiros.length < 4) {
      passageiros.add(passageiro);
    } else {
      print("A carona já está com a capacidade máxima de passageiros.");
    }
  }

  void removerPassageiro(Usuario passageiro) {
    if (passageiros.length > 0) passageiros.remove(passageiro);
  }
}
