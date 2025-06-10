// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'tugas_profil.dart';
import 'tugas_belanja.dart';
import 'tugas_catatan.dart';

class Praktikum3Page extends StatelessWidget {
  const Praktikum3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 3'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TugasProfilPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Tugas 1: Profil Pengguna'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TugasBelanjaPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Tugas 2: Daftar Belanja (Provider)'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TugasCatatanPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Tugas 3: Catatan (Provider & Lifecycle)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
