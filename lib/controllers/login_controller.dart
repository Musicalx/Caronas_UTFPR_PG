import 'package:caronas_utfpr/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:caronas_utfpr/repositories/usuario_repository.dart';

class LoginController extends ChangeNotifier {
  bool logado = false;
  late Usuario usuarioLogado;

  Future<bool> validarLogin(String ra, String senha) async {
    bool raValido = false;
    bool senhaValida = false;
    Usuario? usuario;
    for (int i = 0; i < UsuarioRepository.usuarios.length; i++) {
      if (ra == UsuarioRepository.usuarios[i].ra) {
        raValido = true;
        usuario = UsuarioRepository.usuarios[i];
      }
    }

    if ((raValido)) {
      if (usuario != null && usuario.senha == senha) {
        senhaValida = true;
      }

      if ((senhaValida)) {
        logado = true;
        usuarioLogado = usuario!;
        notifyListeners();
      }
    }

    return senhaValida;
  }
}
