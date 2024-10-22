import 'package:compra/util/colors_config.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/cadastro/components/cadastro_header.dart';
import 'package:compra/ui/_common/email_field.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 64),
            const Align(
              alignment: Alignment.center,
              child: CadastroHeader(
                titulo: "Vamos Começar",
                subtitulo:
                    "Digite as informações solicitadas nos \n campos abaixo para se cadastrar",
              ),
            ),
            const SizedBox(height: 68),
            const EmailField(hint: "Digite seu email", label: "Email"),
            const SizedBox(height: 16),
            const EmailField(hint: "Digite sua senha", label: "Senha"),
            const SizedBox(height: 16),
            const EmailField(hint: "Repita sua senha", label: "Confirmar senha"),
            const SizedBox(height: 48),
            const EmailField(hint: "(99) 99999-9999", label: "Telefone"),
            const SizedBox(height: 16),
            const EmailField(hint: "Digite sua chave pix", label: "Chave Pix"),
            const SizedBox(height: 84),
            DefaultButton(
              color: AppColors.darkGreen,
              label: "Criar Conta",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
