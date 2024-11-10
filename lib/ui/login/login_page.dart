import 'package:compra/Util/colors_config.dart';
import 'package:compra/manager/auth_manager.dart';
import 'package:compra/models/response_model.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/password_field.dart';
import 'package:compra/ui/home/home_page.dart';
import 'package:compra/ui/login/components/divider_with_text.dart';
import 'package:compra/ui/login/components/reset_password_btn.dart';
import 'package:compra/ui/login/components/social_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/_common/snackbar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    // String email = emailController.text.trim();
    // String password = passwordController.text.trim();
    String email =  "eduardo@gmail.com";
    String password =  "123456";

    ResponseModel? response =
        await Provider.of<AuthManager>(context, listen: false)
            .login(context, email, password);

    if (!mounted) return;

    if (response != null && response.statusCode == 200) {
      SnackBarService.showSuccess("Login realizado com sucesso!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      SnackBarService.showError("Login falhou. Verifique suas credenciais.");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              subtitle: "Olá, seja bem-vindo(a)! \nPara começar identifique-se",
            ),
            const SizedBox(height: 64),
            InputField(
              hint: "Digite seu email",
              label: "Email",
              controller: emailController,
            ),
            const SizedBox(height: 8),
            PasswordField(
              hint: "Digite sua senha",
              label: "Senha",
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            const ResetPasswordBtn(),
            const SizedBox(height: 16),
            DefaultButton(
              color: AppColors.darkGreen,
              label: "Entrar",
              onPressed: _login,
            ),
            const DividerWithText(text: "ou"),
            const SizedBox(height: 16),
            const SocialBtn(
                text: "Entrar com o Facebook",
                path: "lib/assets/images/face_icon.png"),
            const SizedBox(height: 16),
            const SocialBtn(
                text: "Entrar com o Google",
                path: "lib/assets/images/google_icon.png"),
          ],
        ),
      ),
    );
  }
}
