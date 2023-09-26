import 'package:caronas_utfpr/app.dart';
import 'package:caronas_utfpr/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<LoginController>.value(
      value: LoginController(),
      child: CaronasUTFPR(),
    ),
  );
}
