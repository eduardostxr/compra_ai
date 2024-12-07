import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/item_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/ui/home/components/account_bottom_sheet.dart';
import 'package:compra/ui/home/components/general_home_btn.dart';
import 'package:compra/ui/home/components/item_bottom_sheet.dart';
import 'package:compra/ui/home/components/item_description_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_item.dart';
import 'package:compra/ui/home/components/list_manager_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_profile_group.dart';
import 'package:compra/ui/new_item/new_item_page.dart';
import 'package:compra/ui/update_item/update_item_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:compra/ui/home/components/list_profile_group_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void _showBottomSheet(Widget bottomSheetWidget) {
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
    return Consumer3<ListManager, AuthManager, ItemManager>(
      builder: (context, listManager, authManager, itemManager, child) =>
          Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.orange,
          title: Row(
            children: [
              Text(
                "Olá, ${context.read<AuthManager>().logedUser.name}!",
                textAlign: TextAlign.left,
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.white),
              onPressed: () {
                _showBottomSheet(const AccountBottomSheet());
              },
            ),
          ],
        ),
        backgroundColor: AppColors.offWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListProfileGroupHeader(
                  text: "Minhas Listas",
                  onPressed: () {},
                ),
                ListProfileGroup(
                  profiles: context.watch<ListManager>().lists,
                  onProfileTap: (listModel) {
                    Provider.of<ListManager>(context, listen: false)
                        .completeList = null;
                    listManager.getListItems(
                        context.read<AuthManager>().accessToken, listModel.id);
                  },
                ),
                const SizedBox(height: 8),
                GeneralHomeBtn(
                  icon: Icons.list_outlined,
                  label: "Gerenciar Lista",
                  onPressed: () {
                    _showBottomSheet(ListManagerBottomSheet());
                  },
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NewItemPage(
                            listId:
                                context.read<ListManager>().completeList!.id,
                          );
                        },
                      ),
                    ).then((_) {
                      if (context.mounted) {
                        final listManager = context.read<ListManager>();
                        final authManager = context.read<AuthManager>();
                        listManager.getListItems(
                          authManager.accessToken,
                          listManager.completeList!.id,
                        );
                      }
                    });
                  },
                ),
                listManager.completeList != null &&
                        listManager.completeList!.items.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listManager.completeList!.items.length,
                        itemBuilder: (context, index) => ListItem(
                          item: context
                              .watch<ListManager>()
                              .completeList!
                              .items[index],
                          onInfoPressed: () {
                            _showBottomSheet(
                              ItemDescriptionBottomSheet(
                                item: context
                                    .read<ListManager>()
                                    .completeList!
                                    .items[index],
                              ),
                            );
                          },
                          onMorePressed: () {
                            _showBottomSheet(
                              ItemBottomSheet(
                                title: context
                                    .read<ListManager>()
                                    .completeList!
                                    .items[index]
                                    .name,
                                onDeleted: () {
                                  itemManager
                                      .deleteItem(
                                    itemId: context
                                        .read<ListManager>()
                                        .completeList!
                                        .items[index]
                                        .id,
                                    token: authManager.accessToken,
                                  )
                                      .then((_) {
                                    if (context.mounted) {
                                      final listManager =
                                          context.read<ListManager>();
                                      listManager.getListItems(
                                        authManager.accessToken,
                                        listManager.completeList!.id,
                                      );
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                                onEdited: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpdateItemPage(
                                          item: context
                                              .read<ListManager>()
                                              .completeList!
                                              .items[index],
                                        );
                                      },
                                    ),
                                  ).then((_) {
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                          onChecked: () {
                            itemManager.checkItem(
                              itemId: context
                                  .read<ListManager>()
                                  .completeList!
                                  .items[index]
                                  .id,
                              token: authManager.accessToken,
                              listManager: listManager,
                            );
                          },
                        ),
                      )
                    : const SizedBox(
                        height: 100,
                        child: Center(child: Text('Sem itens')),
                      ),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
