import 'package:compra/manager/list_manager.dart';
import 'package:compra/ui/_common/custom_bottom_sheet.dart';
import 'package:compra/ui/_common/sheet_button.dart';
import 'package:compra/ui/start/starting_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountBottomSheet extends StatelessWidget {
  const AccountBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: "Gerenciar conta",
      children: [
        SheetButton(
            color: AppColors.red,
            onPressed: () {
              Provider.of<ListManager>(context, listen: false).completeList = null;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const StartingPage(),
                ),
                (route) => false,
              );
            },
            icon: Icons.exit_to_app_outlined,
            label: "Sair")
      ],
    );
  }
}
