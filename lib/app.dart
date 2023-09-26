import 'package:caronas_utfpr/pages/login_page.dart';
import 'package:flutter/material.dart';

class CaronasUTFPR extends StatelessWidget {
  const CaronasUTFPR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caronas UTFPR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: LoginPage(),
    );
  }
}
