import 'package:flutter/material.dart';
import 'screens/category_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final _customColor = Color(0xFF3F5EFB);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: _customColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _customColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: _customColor,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(color: Colors.grey[700]),
        ),
        useMaterial3: true,
      ),
      home: GradientScaffold(child: CategoryListScreen()),
    );
  }
}

class GradientScaffold extends StatelessWidget {
  final Widget child;

  const GradientScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xAA3F5EFB),
                Color(0xAAF7797D),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
