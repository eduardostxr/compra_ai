import 'package:compra/ui/_common/snackbar_service.dart';
import 'package:compra/ui/start/starting_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: SnackBarService.messengerKey,
      title: 'Compra.AI',
      home: const StartingPage(),
    );
  }
}
