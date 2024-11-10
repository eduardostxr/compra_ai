import 'package:compra/manager/user_manager.dart';
import 'package:compra/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manager/auth_manager.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProvider(create: (context) => UserManager()),
      ],
      child: const MyApp(),
    ),
  );
}