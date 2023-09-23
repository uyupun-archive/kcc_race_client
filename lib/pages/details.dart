import 'package:flutter/material.dart';
import 'package:kcc_race_client/router.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Page ID: $id')),
      body: Center(
        child: TextButton(
          onPressed: () => router.pop(),
          child: const Text('Go back to the Top Page'),
        ),
      ),
    );
  }
}
