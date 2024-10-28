import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/ui/_common/password_field.dart';
import 'package:compra/ui/login/login_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
      ),
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.center,
              child: GenericPageHeader(title: "Vamos Começar", subtitle: "Digite as informações solicitadas nos \n campos abaixo para se cadastrar")
            ),
            const SizedBox(height: 40),
            const InputField(hint: "Digite seu email", label: "Email"),
            const SizedBox(height: 8),
            const PasswordField(hint: "Digite sua senha", label: "Senha"),
            const SizedBox(height: 8),
            const PasswordField(hint: "Repita sua senha", label: "Confirmar senha"),
            const SizedBox(height: 40),
            const InputField(hint: "(99) 99999-9999", label: "Telefone"),
            const SizedBox(height: 40),
            const InputField(hint: "Digite sua chave pix", label: "Chave Pix"),
            const SizedBox(height: 40),
            DefaultButton(
              color: AppColors.darkGreen,
              label: "Criar Conta",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
