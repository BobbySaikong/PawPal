import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pawpal/views/registerpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const RegisterScreen(),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('PawPal'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Title(
              color: Colors.blueGrey,
              child: Text(
                'PawPal',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 50),
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.all(20)),
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
