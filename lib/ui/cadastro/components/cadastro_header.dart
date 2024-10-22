import 'package:compra/Util/colors_config.dart';
import 'package:flutter/material.dart';

class CadastroHeader extends StatelessWidget {
  const CadastroHeader({
    super.key,
    required this.titulo,
    required this.subtitulo,
  
  });

  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          titulo,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkGray),
        ),
        Text(
          subtitulo,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.darkGray),
        )
      ],
    );
  }
}
