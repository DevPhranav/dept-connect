import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/logo.png'),
              const SizedBox(height: 20),
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
            ],
          ),
        ),
      ),
    );
  }
}
