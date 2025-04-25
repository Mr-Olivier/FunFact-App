import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funfacts/screens/settings_screen.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> facts = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure widget is built before making API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  Future<void> getData() async {
    if (!mounted) return;

    try {
      final dio = Dio();
      final response = await dio.get(
        "https://raw.githubusercontent.com/Mr-Olivier/flutter_dummy_api/refs/heads/main/facts.json",
      );

      if (!mounted) return; // Check again after async operation

      if (response.statusCode == 200) {
        setState(() {
          try {
            // Handle both string and already parsed JSON
            if (response.data is String) {
              facts = jsonDecode(response.data);
            } else {
              facts = response.data;
            }
            isLoading = false;
          } catch (e) {
            errorMessage = "Error parsing data: $e";
            isLoading = false;
          }
        });
      } else {
        setState(() {
          errorMessage = "Error: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = "Network error: $e";
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fun Facts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : facts.isEmpty
                    ? const Center(child: Text("No facts available"))
                    : PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: facts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                facts[index].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
          Container(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Swipe left for more"),
            ),
          ),
        ],
      ),
    );
  }
}
