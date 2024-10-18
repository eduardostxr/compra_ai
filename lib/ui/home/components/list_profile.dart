import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ListProfile extends StatelessWidget {
  const ListProfile({
    super.key,
    required this.title,
    required this.emoji,
    required this.isSelected,
    required this.onSelected,
  });

  final String title;
  final String emoji;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onSelected,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightPeach,
                border: Border.all(
                  color: isSelected ? AppColors.orange : Colors.transparent,
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.darkGray,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}
