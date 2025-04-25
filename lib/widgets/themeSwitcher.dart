import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/themeProvider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Theme Mode",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Switch(
                    value: themeProvider.isDarkModeChecked,
                    onChanged: (value) {
                      themeProvider.updateMode(darkMode: value);
                    },
                  ),
                  const SizedBox(width: 20),
                  Text(
                    themeProvider.isDarkModeChecked
                        ? "Dark Mode"
                        : "Light Mode",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
