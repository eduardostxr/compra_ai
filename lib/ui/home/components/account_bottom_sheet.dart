import 'package:compra/ui/_common/custom_bottom_sheet.dart';
import 'package:compra/ui/start/starting_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class AccountBottomSheet extends StatelessWidget {

  const AccountBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: "Gerenciar conta",
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
    );
  }
}
