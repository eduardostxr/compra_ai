import 'package:compra/manager/auth_manager.dart';
import 'package:compra/models/response_model.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/ui/_common/password_field.dart';
import 'package:compra/ui/start/starting_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:flutter/material.dart';

import '../_common/snackbar_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  CadastroPageState createState() => CadastroPageState();
}

class CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pixKeyController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _pixKeyController.dispose();
    super.dispose();
  }

  Future<void> handleSignUp(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      AuthManager authManager = AuthManager();
      ResponseModel? response = await authManager.signUp(
        context,
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneController.text,
        _pixKeyController.text,
      );

      if (context.mounted) {
        Navigator.pop(context);

        if (response != null && response.statusCode == 201) {
          SnackBarService.showSuccess(response.message);
          await Future.delayed(const Duration(seconds: 2));
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const StartingPage(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        } else {
          SnackBarService.showError(response?.message ?? "Erro desconhecido");
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        SnackBarService.showError("Erro inesperado");
      }
    }
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.center,
              child: GenericPageHeader(
                title: "Vamos Começar",
                subtitle:
                    "Digite as informações solicitadas nos \n campos abaixo para se cadastrar",
              ),
            ),
            const SizedBox(height: 40),
            InputField(
              hint: "Digite seu nome",
              label: "Nome",
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 8),
            InputField(
              hint: "Digite seu email",
              label: "Email",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            PasswordField(
              hint: "Digite sua senha",
              label: "Senha",
              controller: _passwordController,
            ),
            const SizedBox(height: 8),
            PasswordField(
              hint: "Repita sua senha",
              label: "Confirmar senha",
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 40),
            InputField(
              hint: "(99) 99999-9999",
              label: "Telefone",
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 40),
            InputField(
              hint: "Digite sua chave pix",
              label: "Chave Pix",
              controller: _pixKeyController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 40),
            DefaultButton(
              color: AppColors.darkGreen,
              label: "Criar Conta",
              onPressed: () async {
                await handleSignUp(context);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
