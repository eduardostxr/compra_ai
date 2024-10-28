import 'package:compra/Util/colors_config.dart';
import 'package:compra/ui/_common/dashed_border.dart';
import 'package:compra/ui/new_list/new_list_page.dart';
import 'package:flutter/material.dart';

class AddListButton extends StatelessWidget {
  const AddListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightPeach,
            ),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewListPage(),
                ),
              ),
              splashColor: AppColors.orange.withOpacity(0.2),
              highlightColor: AppColors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: 60,
                height: 60,
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
