import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ResetPasswordBtn extends StatelessWidget {
  const ResetPasswordBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsetsDirectional.only(end: 24),
        child: TextButton(
            onPressed: () {},
            child: const Text(
              "Esqueci minha senha",
              style: TextStyle(color: AppColors.darkGray),
            )));
  }
}
