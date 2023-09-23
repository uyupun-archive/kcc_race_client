import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:kcc_race_client/router.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _State();
}

class _State extends State<Chat> {
  final TextEditingController _controller = TextEditingController();
  late IO.Socket _socket;
  final List<SocketData> socketData = [];
  late String id = '';
  late bool loading = true;
  late bool canSend = false;

  void textListener() {
    setState(() {
      canSend = _controller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _socket = IO.io(
      dotenv.get('API_URL'),
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    _socket.connect();
    _socket.onConnect((_) {
      print('---connect---');
      // idを受け取る
      _socket.on('id', (res) {
        setState(() {
          id = res;
        });
      });

      // ローディングの状態を受け取る
      _socket.on('loading', (res) {
        setState(() {
          loading = res;
        });
      });

      // メッセージを受け取る
      _socket.on('message', (res) {
        setState(() {
          socketData.add(SocketData.fromJson(res));
        });
      });

      // 勝敗を受け取る
      _socket.on('winner', (res) {
        _showWinnerDialog(res);
      });
    });

    _controller.addListener(textListener);
  }

  @override
  void dispose() {
    _socket.disconnect();
    _socket.onDisconnect((_) => print('disconnect'));
    _controller.removeListener(textListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: loading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '他のユーザーを待っています。。。',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Row(
                          mainAxisAlignment: socketData[index].id == id
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (socketData[index].id != id) ...[
                              const Icon(Icons.account_circle_outlined),
                              const SizedBox(width: 4),
                            ],
                            Flexible(
                              child: Text(
                                socketData[index].message,
                              ),
                            ),
                            if (socketData[index].id == id) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.account_circle_outlined),
                            ],
                          ],
                        ),
                      ),
                      itemCount: socketData.length,
                    ),
                  ),
                  Form(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              labelText: 'チクチク言葉を入力',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          iconSize: 32,
                          onPressed: _sendMessage,
                          icon: Icon(
                            Icons.send,
                            color: canSend ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _socket.emit('post-message', {
        'id': id,
        'message': _controller.text,
      });
      _controller.clear();
    }
  }

  void _showWinnerDialog(bool winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(winner ? 'あなたの勝ち！' : 'あなたの負け！'),
          content: Text(
            winner ? '🎉' : '🤯',
            style: const TextStyle(fontSize: 64),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                '終了',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                const TopRoute().go(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class SocketData {
  String message = "";
  String id = "id";

  SocketData();

  SocketData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'];
}
