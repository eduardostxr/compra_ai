import 'package:compra/Util/colors_config.dart';
import 'package:compra/_common/dashed_border.dart';
import 'package:flutter/material.dart';

class AddListButton extends StatefulWidget {
  const AddListButton({super.key});

  @override
  State<AddListButton> createState() => _AddListButtonState();
}

class _AddListButtonState extends State<AddListButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightPeach,
            ),
            child: Stack(
              children: [
                CustomPaint(
                  painter: DashedBorderPainter(color: AppColors.orange),
                  size: const Size(60, 60),
                ),
                const Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.orange,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
