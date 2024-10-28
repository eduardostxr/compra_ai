import 'package:compra/Util/colors_config.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final String hint;

  const InputField({super.key, required this.hint, required this.label});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: const TextStyle(
                color: AppColors.darkGray,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(color: AppColors.mediumGray),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkGreen, width: 2),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.orange, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
