// lib/main.dart

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shopatsin_mobile/screens/login.dart';
import 'package:shopatsin_mobile/menu.dart';

void main() {
  runApp(const ShopAtSinApp());
}

class ShopAtSinApp extends StatelessWidget {
  const ShopAtSinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: "ShopAtSin",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green.shade700,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          MyHomePage.homeRoute: (context) =>
              const MyHomePage(title: "ShopAtSin"),
          AddProductPage.routeName: (context) => const AddProductPage(),
        },
      ),
    );
  }
}
