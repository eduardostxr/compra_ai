import 'package:compra/ui/_common/custom_bottom_sheet.dart';
import 'package:compra/ui/_common/sheet_button.dart';
import 'package:compra/ui/start/starting_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

class ListManagerBottomSheet extends StatelessWidget {
  const ListManagerBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: "Gerenciar Lista",
      children: [
        SheetButton(
          color: AppColors.darkGray,
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const StartingPage(),
            ),
            (route) => false,
          ),
          icon: Icons.edit_outlined,
          label: "Editar lista",
        ),
        const SizedBox(height: 10),
        SheetButton(
          color: AppColors.darkGray,
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const StartingPage(),
            ),
            (route) => false,
          ),
          icon: Icons.person_add_outlined,
          label: "Convidar amigos",
        ),
        const Divider(
          height: 32,
        ),
        SheetButton(
          color: AppColors.red,
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const StartingPage(),
            ),
            (route) => false,
          ),
          icon: Icons.exit_to_app_outlined,
          label: "Deletar lista",
        ),
      ],
    );
  }
}
