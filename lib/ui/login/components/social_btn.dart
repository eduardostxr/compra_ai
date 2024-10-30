import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class SocialBtn extends StatelessWidget {
  final String text;
  final String path;
  const SocialBtn({super.key, required this.text, required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(double.infinity ,50),
          foregroundColor: AppColors.darkGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              path,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
