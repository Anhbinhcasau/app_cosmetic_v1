import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_cosmetic/screen/user/splashscreen/splashscreen2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen1 extends StatelessWidget {
  const Splashscreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          children: [
            Center(
                child: LottieBuilder.asset("./assets/Lottie/Animation_1.json")),
          ],
        ),
        nextScreen: Splashscreen2(),
        splashIconSize: 550,
        duration: 5000);
  }
}
