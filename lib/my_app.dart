import 'package:compra/ui/cadastro/cadastro_page.dart';
import 'package:compra/ui/login/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Compra.AI',
      home: CadastroPage(),
    );
  }
}
