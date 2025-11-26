import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';
import 'package:pawpal/models/user.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({super.key, required this.user});
  
  

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  

  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Column(children: [Text('Welcome! }', style: TextStyle(fontSize: 50))]),
        ),
      ),
    );
  }
}
