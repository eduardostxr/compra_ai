import 'package:compra/Util/colors_config.dart';
import 'package:flutter/material.dart';

class GenericPageHeader extends StatelessWidget {
  const GenericPageHeader(
      {super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.darkGray),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.darkGray, fontSize: 16),
        )
      ],
    );
  }
}
