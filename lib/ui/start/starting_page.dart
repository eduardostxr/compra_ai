import 'package:compra/ui/register/register_page.dart';
import 'package:compra/ui/login/login_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

import '../_common/default_button.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/logo.png'),
          const SizedBox(height: 100),
          DefaultButton(
            color: AppColors.orange,
            label: "Cadastrar-se",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 26),
          DefaultButton(
            color: AppColors.darkGreen,
            label: "Entrar",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          )
        ],
      )),
    );
  }
}
