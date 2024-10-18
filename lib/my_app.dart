import 'package:compra/ui/home/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Compra.AI',
      home: MyHomePage(title: "Olá, Usuário"),
    );
  }
}