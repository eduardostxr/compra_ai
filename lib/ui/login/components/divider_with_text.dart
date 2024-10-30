import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: AppColors.mediumGray,
              thickness: 1,
              endIndent: 8,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.mediumGray,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Expanded(
            child: Divider(
              color: AppColors.mediumGray,
              thickness: 1,
              indent: 8,
            ),
          ),
        ],
      ),
    );
  }
}
