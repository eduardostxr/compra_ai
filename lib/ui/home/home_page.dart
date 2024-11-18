import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/manager/user_manager.dart';
import 'package:compra/models/list_model.dart';
import 'package:compra/ui/home/components/account_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_item.dart';
import 'package:compra/util/colors_config.dart';
import 'package:compra/ui/home/components/general_home_btn.dart';
import 'package:compra/ui/home/components/list_profile_group.dart';
import 'package:compra/ui/home/components/list_profile_group_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> profiles = [];
  String userName = "Usuário";

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchLists();
  }

  void _fetchUserName() async {
    final authManager = Provider.of<AuthManager>(context, listen: false);
    final userManager = Provider.of<UserManager>(context, listen: false);

    final token = authManager.accessToken;
    if (token.isNotEmpty) {
      final response = await userManager.getMe(context, token);
      if (response != null && response.statusCode == 200) {
        setState(() {
          userName = userManager.logedUser.name.split(" ").first;
        });
      }
    }
  }

  void _fetchLists() async {
    try {
      final authManager = Provider.of<AuthManager>(context, listen: false);
      final listManager = ListManager(context);

      final token = authManager.accessToken;
      if (token.isNotEmpty) {
        final response = await listManager.getLists();
        if (response != null && response.statusCode == 200) {
          final data = response.value as List<dynamic>;
          setState(() {
            profiles = data
                .map((json) => ListModel.fromJson(json))
                .map((list) => {
                      "id": list.id.toString(),
                      "title": list.name,
                      "emoji": list.emoji,
                    })
                .toList();
          });
        }
      }
    } catch (error) {
      debugPrint("Error fetching lists: $error");
    }
  }

  void _showAccountBottomSheet(Widget bottomSheetWidget) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return bottomSheetWidget;
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
              "Olá, $userName!",
              style: const TextStyle(color: AppColors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.white),
            onPressed: () =>
                _showAccountBottomSheet(const AccountBottomSheet()),
          ),
        ],
      ),
      backgroundColor: AppColors.offWhite,
      body: profiles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                ListItem(
                  name: "Arroz",
                  onInfoPressed: () {},
                  onMorePressed: () {},
                  onChecked: (isChecked) {},
                )
              ],
            ),
    );
  }
}
