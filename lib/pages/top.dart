import 'package:flutter/material.dart';
import 'package:kcc_race_client/router.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageWidth = width < 340 ? width : 340;

    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 75),
                Image.asset(
                  'lib/assets/title.png',
                  width: imageWidth,
                  fit: BoxFit.fitWidth,
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () {
                    const ChatRoute().go(context);
                  },
                  child: Image.asset(
                    'lib/assets/balloon.png',
                    width: imageWidth,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
