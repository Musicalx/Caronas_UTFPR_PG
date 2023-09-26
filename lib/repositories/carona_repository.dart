import 'package:caronas_utfpr/models/carona.dart';
import 'package:caronas_utfpr/models/usuario.dart';
import 'package:caronas_utfpr/repositories/usuario_repository.dart';

class CaronaRepository {
  static List<Carona> tabela = [
    Carona(
        condutor: UsuarioRepository.usuarios[1],
        local: 'Condor',
        vagas: 3,
        preco: 2.00,
        dia: '27/09',
        hora: '14:15',
        sentidoUtf: true),
    Carona(
        condutor: UsuarioRepository.usuarios[2],
        local: 'Tozetto',
        vagas: 2,
        preco: 6.00,
        dia: '27/09',
        hora: '18:20',
        sentidoUtf: false),
    Carona(
        condutor: UsuarioRepository.usuarios[3],
        local: 'Monteiro Lobato',
        vagas: 1,
        preco: 3.00,
        dia: '27/09',
        hora: '07:00',
        sentidoUtf: true),
    Carona(
        condutor: UsuarioRepository.usuarios[4],
        local: 'Centro',
        vagas: 3,
        preco: 10.00,
        dia: '27/09',
        hora: '09:30',
        sentidoUtf: false)
  ];
  static void reservarCarona(int indice, Usuario passageiro) {
    if (indice >= 0 && indice < tabela.length) {
      if (tabela[indice].vagas > 0) {
        tabela[indice].vagas--;
        tabela[indice].adicionarPassageiro(passageiro);
      }
    }
  }

  static void cancelarPassageiro(int indice, Usuario passageiro) {
    if (indice >= 0 && indice < tabela.length) {
      tabela[indice].vagas++;
      tabela[indice].removerPassageiro(passageiro);
    }
  }

  static void excluirCarona(int indice) {
    if (indice >= 0 && indice < tabela.length) {
      tabela.removeAt(indice);
    }
  }

  static void finalizarCarona(int indice) {
    if (indice >= 0 && indice < tabela.length) {
      tabela[indice].finalizado = true;
    }
  }
}
