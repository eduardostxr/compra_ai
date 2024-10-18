import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class GeneralHomeBtn extends StatelessWidget { // StatelessWidget ou StatefulWidget
  const GeneralHomeBtn(
      {super.key,
      // required this.color,
      required this.icon,
      required this.label,
      required this.onPressed});

  // final Colors color;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      width: double.infinity,
      height: 60,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.lightGray,
          foregroundColor: AppColors.darkGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Text(label),
          ],
        ),
      ),
    );
  }
}
