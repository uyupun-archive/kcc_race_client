import 'package:flutter/material.dart';
import 'package:hackathon_boilerplate_flutter/router.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Page')),
      body: Center(
        child: TextButton(
          onPressed: () => const DetailsRoute(id: 1).push(context),
          child: const Text('Go to the Details page'),
        ),
      ),
    );
  }
}
