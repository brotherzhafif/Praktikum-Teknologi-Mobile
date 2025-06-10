import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Praktikum1Page extends StatefulWidget {
  const Praktikum1Page({super.key});

  @override
  State<Praktikum1Page> createState() => _Praktikum1PageState();
}

class _Praktikum1PageState extends State<Praktikum1Page> {
  String title = "Loading...";
  String name = "Loading...";
  bool isLoading = true;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          // 'User-Agent': 'Mozilla/5.0', // Uncomment if needed for some APIs
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          title = data['username']?.toString() ?? 'No username';
          name = data['name']?.toString() ?? 'No name available';
          isLoading = false;
          errorMsg = null;
        });
      } else {
        setState(() {
          title = "Failed to load data";
          name = "Failed to load data";
          isLoading = false;
          errorMsg = "Status: ${response.statusCode}\n${response.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        title = "Failed to load data";
        name = "Failed to load data";
        isLoading = false;
        errorMsg = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Praktikum 1"), backgroundColor: Colors.teal),
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
                    ? CircularProgressIndicator()
                    : errorMsg != null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text(
                          "Gagal memuat data",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        SizedBox(height: 8),
                        Text(
                          errorMsg!,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
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
                          style: TextStyle(fontSize: 18, color: Colors.black87),
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
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
