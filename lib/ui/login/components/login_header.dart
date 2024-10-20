import 'package:compra/Util/colors_config.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Acesse agora",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.darkGray),
        ),
        Text(
          "Olá, seja bem vindo(a)! \nPara começar identifique-se",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.darkGray),
        )
      ],
    );
  }
}
