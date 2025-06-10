import 'package:flutter/material.dart';

class Praktikum4Page extends StatelessWidget {
  const Praktikum4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Praktikum 4"), backgroundColor: Colors.teal),
      body: Center(
        child: Text("Halaman Praktikum 4", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
