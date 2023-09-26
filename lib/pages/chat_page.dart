import 'package:caronas_utfpr/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:caronas_utfpr/models/mensagens.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final List<Mensagem> mensagens;
  final String remetente;

  ChatPage({required this.mensagens, required this.remetente});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  late LoginController logado;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logado = Provider.of<LoginController>(context);
  } //só funcionou o provider usando esse metodo por conta do _enviarMensagem estar fora do build

  @override
  Widget build(BuildContext context) {
    final logado = Provider.of<LoginController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.remetente),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.mensagens.length,
              itemBuilder: (context, index) {
                final mensagem = widget.mensagens[index];
                bool isSentMessage =
                    mensagem.remetente.nome == logado.usuarioLogado.nome;

                return Align(
                  alignment: isSentMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSentMessage ? Colors.blue : Colors.grey[300],
                      borderRadius: isSentMessage
                          ? BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(0),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(12),
                            ),
                    ),
                    child: Text(
                      mensagem.mensagem,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSentMessage ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _enviarMensagem();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _enviarMensagem() {
    String mensagemTexto = _messageController.text;
    if (mensagemTexto.isNotEmpty) {
      Mensagem novaMensagem = Mensagem(
        remetente: logado.usuarioLogado,
        mensagem: mensagemTexto,
        dataHora: DateTime.now(),
      );
      setState(() {
        widget.mensagens.add(novaMensagem);
      });

      _messageController.clear();
    }
  }
}
