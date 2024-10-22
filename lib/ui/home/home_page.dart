import 'package:compra/ui/home/components/home_bottom_sheet.dart';
import 'package:compra/util/colors_config.dart';
import 'package:compra/ui/home/components/general_home_btn.dart';
import 'package:compra/ui/home/components/list_profile_group.dart';
import 'package:compra/ui/home/components/list_profile_group_header.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> profiles = [
    {"id": "1", "title": "Lista 1", "emoji": "😀"},
    {"id": "2", "title": "Lista 2", "emoji": "🎉"},
    {"id": "3", "title": "Lista 3", "emoji": "🌍"},
    {"id": "4", "title": "Lista 4", "emoji": "🐧"},
    {"id": "5", "title": "Lista 5", "emoji": "🚀"},
    {"id": "6", "title": "Lista 6", "emoji": "🍕"},
  ];

    void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return HomeBottomSheet(profiles: profiles);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: AppColors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.white),
            onPressed: _showBottomSheet,
          ),
        ],
      ),
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          ListProfileGroupHeader(
            onPressed: () {},
          ),
          ListProfileGroup(
            profiles: profiles,
          ),
          const SizedBox(height: 8),
          GeneralHomeBtn(
            icon: Icons.list_outlined,
            label: "Gerenciar Lista",
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          GeneralHomeBtn(
            icon: Icons.camera_alt_outlined,
            label: "Nota Fiscal",
            onPressed: () {},
          ),
          const SizedBox(height: 32),
          GeneralHomeBtn(
            icon: Icons.add,
            label: "Adicionar Item",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
