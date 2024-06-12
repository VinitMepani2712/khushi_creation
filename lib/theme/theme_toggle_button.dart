import 'package:flutter/material.dart';
import 'package:khushi_creation/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final brightness = Theme.of(context).brightness;

    return IconButton(
      icon: Icon(brightness == Brightness.dark
          ? Icons.light_rounded
          : Icons.dark_mode_rounded),
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
