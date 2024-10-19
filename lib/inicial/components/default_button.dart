import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback onPressed;
  const DefaultButton({super.key, required this.color, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      height: 40,
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(color),
          foregroundColor: WidgetStateProperty.all<Color>(AppColors.offWhite),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
