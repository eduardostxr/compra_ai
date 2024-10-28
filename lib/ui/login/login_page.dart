import 'package:compra/Util/colors_config.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/password_field.dart';
import 'package:compra/ui/home/home_page.dart';
import 'package:compra/ui/login/components/reset_password_btn.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const GenericPageHeader(
                title: "Acesse agora",
                subtitle:
                    "Olá, seja bem-vindo(a)! \nPara começar identifique-se"),
            const SizedBox(height: 64),
            const InputField(hint: "Digite seu email", label: "Email"),
            const SizedBox(height: 8),
            const PasswordField(hint: "Digite sua senha", label: "Senha"),
            const SizedBox(height: 16),
            const ResetPasswordBtn(),
            const SizedBox(height: 16),
            DefaultButton(
              color: AppColors.darkGreen,
              label: "Entrar",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "Olá, Usuário",),
                  ),
                  (Route<dynamic> route) => false,
                  
                );
              },
            
            ),
              const SizedBox(height: 16),
              const InputField(hint: "Entrar com Facebook", label: ""),
              const SizedBox(height: 8,),
              const InputField(hint: "Entrar com Google", label: ""),

              const SizedBox(height: 2),
              const GenericPageHeader(
                title: "", 
                subtitle: "Não tem cadastro? Começar")
          ],
        ),
      ),
    );
  }
}
