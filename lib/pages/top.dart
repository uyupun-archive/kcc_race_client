import 'package:flutter/material.dart';
import 'package:kcc_race_client/router.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Page')),
      body: Center(
        child: TextButton(
          onPressed: () => const ChatRoute().go(context),
          child: const Text('Go to the Chat page'),
        ),
      ),
    );
  }
}
