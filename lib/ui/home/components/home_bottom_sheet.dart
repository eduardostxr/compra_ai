import 'package:compra/ui/start/starting_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class HomeBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> profiles;

  const HomeBottomSheet({
    super.key,
    required this.profiles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
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
                  color: AppColors.mediumGray,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(AppColors.lightGray),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartingPage(),
                  ),
                  (route) => false,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sair', style: TextStyle(color: AppColors.red)),
                    Icon(Icons.exit_to_app_outlined, color: AppColors.red),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
