import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool moreLines;

  const InputField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.moreLines = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
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
          const SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLines: widget.moreLines ? null : 1,
            minLines: widget.moreLines ? 3 : 1,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: AppColors.gray),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.darkGreen, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
