import 'package:flutter/material.dart';
import 'package:compra/util/colors_config.dart';

class EmojiInputField extends StatefulWidget {
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
  State<EmojiInputField> createState() => EmojiInputFieldState();
}

class EmojiInputFieldState extends State<EmojiInputField> {
  String? selectedEmoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: AppColors.darkGray,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(color: AppColors.gray),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.darkGreen, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.orange, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                suffixIcon: GestureDetector(
                  onTap: widget.onEmojiPressed, 
                  child: selectedEmoji == null
                      ? const Icon(Icons.emoji_emotions_outlined, size: 30,)
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            selectedEmoji!,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
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

  void updateEmoji(String emoji) {
    setState(() {
      selectedEmoji = emoji;
    });
  }
}
