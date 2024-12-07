import 'package:compra/manager/item_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manager/auth_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        // ChangeNotifierProvider(create: (context) => UserManager()),
        ChangeNotifierProvider(create: (context) => ListManager()),
        ChangeNotifierProvider(create: (context) => ItemManager()),
        
      ],
      child: const MyApp(),
    ),
  );
}