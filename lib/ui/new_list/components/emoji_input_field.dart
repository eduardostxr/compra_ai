import 'package:flutter/material.dart';
import 'package:compra/util/colors_config.dart';

class EmojiInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final VoidCallback onEmojiPressed;

  const EmojiInputField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    required this.onEmojiPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.darkGray,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: AppColors.mediumGray),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkGreen, width: 2),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orange, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: onEmojiPressed,
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
