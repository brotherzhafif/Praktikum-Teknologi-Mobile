import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = "Loading...";
  String name = "Loading...";
  bool isLoading = true; // Tambahkan state untuk loading

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        title = data['username'];
        name = data['name'] ?? 'No name available';
        isLoading = false; // Set loading ke false setelah data berhasil diambil
      });
    } else {
      setState(() {
        title = "Failed to load data";
        name = "Failed to load data";
        isLoading = false; // Set loading ke false jika gagal
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tugas Praktikum 2 Tekmob King Japip"),
          backgroundColor: Colors.teal, // Warna AppBar
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade100, Colors.teal.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child:
                  isLoading
                      ? CircularProgressIndicator() // Tampilkan loading indicator
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Username:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Name:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
