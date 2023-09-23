import 'package:flutter/material.dart';
import 'package:spajam_2023/router.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Page')),
      body: Center(
        child: TextButton(
          onPressed: () => const TopRoute().go(context),
          child: const Text('Go to the Top page'),
        ),
      ),
    );
  }
}
