import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.darkGray,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightGray,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.close,
                    size: 12,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: children,
          )
        ],
      ),
    );
  }
}
