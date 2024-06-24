import 'package:app_cosmetic/screen/category.dart';
import 'package:app_cosmetic/screen/home.dart';
import 'package:app_cosmetic/screen/profile_user.dart';
import 'package:flutter/material.dart';

class Splashscreen2 extends StatelessWidget {
  const Splashscreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: const Color.fromARGB(219, 255, 255, 255),
      // ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.asset(
                "assets/splash_screen_2.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
