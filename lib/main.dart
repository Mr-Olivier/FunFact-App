import 'package:flutter/material.dart';
import 'package:funfacts/providers/themeProvider.dart';
import 'package:funfacts/screens/mainScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure Flutter is initialized before doing any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Create the ThemeProvider instance first
  final themeProvider = ThemeProvider();
  // Load theme preferences before the app starts
  await themeProvider.loadMode();

  runApp(
    ChangeNotifierProvider.value(value: themeProvider, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          themeProvider.isDarkModeChecked
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}
