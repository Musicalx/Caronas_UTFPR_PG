import 'package:caronas_utfpr/controllers/login_controller.dart';
import 'package:caronas_utfpr/pages/my_caronas_page.dart';
import 'package:flutter/material.dart';
import 'package:caronas_utfpr/models/carona.dart';
import 'package:caronas_utfpr/repositories/carona_repository.dart';
import 'package:provider/provider.dart';

class NovaCaronaPage extends StatefulWidget {
  @override
  _NovaCaronaPageState createState() => _NovaCaronaPageState();
}

class _NovaCaronaPageState extends State<NovaCaronaPage> {
  final _formKey = GlobalKey<FormState>();
  final _localController = TextEditingController();
  final _horaController = TextEditingController();
  final _diaController = TextEditingController();
  final _precoController = TextEditingController();
  final _vagasController = TextEditingController();
  bool? _sentidoUtf = true;

  @override
  Widget build(BuildContext context) {
    final logado = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Carona'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _localController,
                decoration: InputDecoration(labelText: 'Local'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Informe o local da carona';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _diaController,
                decoration: InputDecoration(labelText: 'Dia'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Informe o Dia da carona';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _horaController,
                decoration: InputDecoration(labelText: 'Hora'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Informe a hora da carona';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Informe o preço da carona';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _vagasController,
                decoration: InputDecoration(labelText: 'Vagas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Informe a quantidade de vagas disponíveis';
                  }
                  int? parsedValue = int.tryParse(value!);
                  if (parsedValue == null) {
                    return 'Informe um número válido';
                  }
                  if (parsedValue > 4) {
                    return 'Máximo de vagas: 4';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Sentido:'),
              Row(
                children: <Widget>[
                  Radio<bool>(
                    value: true,
                    groupValue: _sentidoUtf,
                    onChanged: (value) {
                      setState(() {
                        _sentidoUtf = value;
                      });
                    },
                  ),
                  Text('Para UTFPR'),
                  Radio<bool>(
                    value: false,
                    groupValue: _sentidoUtf,
                    onChanged: (value) {
                      setState(() {
                        _sentidoUtf = value;
                      });
                    },
                  ),
                  Text('Da UTFPR'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novaCarona = Carona(
                      condutor: logado.usuarioLogado,
                      local: _localController.text,
                      dia: _diaController.text,
                      hora: _horaController.text,
                      preco: double.parse(_precoController.text),
                      vagas: int.parse(_vagasController.text),
                      sentidoUtf: _sentidoUtf ?? false,
                    );

                    CaronaRepository.tabela.add(novaCarona);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCaronasPage(),
                      ),
                    );
                  }
                },
                child: Text('Criar Carona'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _localController.dispose();
    _diaController.dispose();
    _horaController.dispose();
    _precoController.dispose();
    _vagasController.dispose();
    super.dispose();
  }
}
