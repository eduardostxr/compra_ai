import 'package:compra/Util/colors_config.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/email_field.dart';
import 'package:compra/ui/login/components/login_header.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginHeader(),
            const SizedBox(height: 8),
            const EmailField(hint: "Digite seu email", label: "Email"),
            const SizedBox(height: 8),
            const EmailField(hint: "Digite sua senha", label: "Senha"),
            const SizedBox(height: 8),
            DefaultButton(color: AppColors.darkGreen, label: "Entrar", onPressed: () {})

          ],
        ),
      ),
    );
  }
}
