import 'package:flutter/material.dart';
import 'package:shopatsin/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ShopAtSin",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade700,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: MyHomePage.homeRoute,
      routes: {
        MyHomePage.homeRoute: (context) => const MyHomePage(title: "ShopAtSin"),
        AddProductPage.routeName: (context) => const AddProductPage(),
      },
    );
  }
}
