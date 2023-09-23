import 'package:flutter/material.dart';
import 'package:spajam_2023/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hackathon Boilerplate Flutter',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
