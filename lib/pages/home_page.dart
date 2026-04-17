import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String password;
  const HomeScreen({super.key, required this.username, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [Text("Username: $username abcod"), Text("Password: $password")],
        ),
      ),
    );
  }
}
