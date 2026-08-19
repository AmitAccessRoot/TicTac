// lib/core/app.dart
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../features/counter/presentation/pages/home_page.dart';

class TicTacApp extends StatelessWidget {
  const TicTacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
