import 'package:compra/ui/home/home_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

import 'components/default_button.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 130),
          Image.asset('lib/assets/images/logo.png'),
          const SizedBox(height: 100),
          DefaultButton(
              color: AppColors.orange, label: "Cadastrar-se", onPressed: () {}),
          DefaultButton(
            color: AppColors.darkGreen,
            label: "Entrar",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: "Olá, Mateus")),
              );
            },
          )
        ],
      )),
    );
  }
}
