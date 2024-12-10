import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/item_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/response_model.dart';
import 'package:compra/ui/home/components/account_bottom_sheet.dart';
import 'package:compra/ui/home/components/general_home_btn.dart';
import 'package:compra/ui/home/components/item_bottom_sheet.dart';
import 'package:compra/ui/home/components/item_description_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_item.dart';
import 'package:compra/ui/home/components/list_manager_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_profile_group.dart';
import 'package:compra/ui/new_item/new_item_page.dart';
import 'package:compra/ui/receipt/receipt_page.dart';
import 'package:compra/ui/update_list/update_list_page.dart';
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
  final GlobalKey<ListProfileGroupState> listProfileGroupKey = GlobalKey();
  int inviteCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchInvites();
  }

  void _fetchInvites() {
    final authManager = context.read<AuthManager>();
    context
        .read<ListManager>()
        .getInvites(authManager.accessToken)
        .then((invites) {
      setState(() {
        inviteCount = invites.length;
      });
    });
  }

  void _showInvites() {
    final listManager = context.read<ListManager>();

    _showBottomSheet(
      listManager.invites.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Você não tem convites pendentes.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: listManager.invites.length,
              itemBuilder: (context, index) {
                final invite = listManager.invites[index];
                return ListTile(
                  title: Text(invite.list.name),
                  subtitle: Text("Convidado por: ${invite.invitedBy.name}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          listManager
                              .acceptInvite(
                            context.read<AuthManager>().accessToken,
                            invite.id,
                          )
                              .then((_) {
                            _fetchInvites();
                            Navigator.pop(context);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          listManager
                              .declineInvite(
                            context.read<AuthManager>().accessToken,
                            invite.id,
                          )
                              .then((_) {
                            _fetchInvites();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
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

  void _redirectToReceiptPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ReceiptPage()));
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
            Badge(
              label: Text(
                inviteCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              isLabelVisible: inviteCount > 0,
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: _showInvites,
              ),
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
                  key: listProfileGroupKey,
                  list: listManager.lists,
                  onProfileTap: (listModel) {
                    listManager.getListItems(
                        context.read<AuthManager>().accessToken, listModel.id);
                  },
                ),
                const SizedBox(height: 8),
                listManager.completeList != null
                    ? GeneralHomeBtn(
                        icon: Icons.list_outlined,
                        label: "Gerenciar Lista",
                        onPressed: () {
                          _showBottomSheet(
                            ListManagerBottomSheet(
                              onDeleted: () {
                                listManager.deleteList(
                                  authManager.accessToken,
                                  listManager.completeList!.id,
                                );
                                listProfileGroupKey.currentState
                                    ?.resetSelection();

                                context.read<ListManager>().completeList = null;
                                context.read<ListManager>().lists;
                              },
                              onEdited: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return UpdateListPage(
                                        list: context
                                            .read<ListManager>()
                                            .completeList!,
                                      );
                                    },
                                  ),
                                ).then(
                                  (_) {
                                    if (context.mounted) {
                                      listManager.getLists(
                                        context.read<AuthManager>().accessToken,
                                      );
                                    }
                                  },
                                );
                              },
                              onInvited: () {},
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                const SizedBox(height: 8),
                listManager.completeList != null
                    ? GeneralHomeBtn(
                        icon: Icons.camera_alt_outlined,
                        label: "Nota Fiscal",
                        onPressed: _redirectToReceiptPage,
                      )
                    : const SizedBox(),
                const SizedBox(height: 32),
                listManager.completeList != null
                    ? GeneralHomeBtn(
                        icon: Icons.add,
                        label: "Adicionar Item",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewItemPage(
                                  listId: context
                                      .read<ListManager>()
                                      .completeList!
                                      .id,
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
                      )
                    : const SizedBox(),
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
                                onDeleted: () async {
                                  ResponseModel? response =
                                      await itemManager.deleteItem(
                                    itemId: context
                                        .read<ListManager>()
                                        .completeList!
                                        .items[index]
                                        .id,
                                    token: authManager.accessToken,
                                  );

                                  if (response != null &&
                                      response.statusCode == 200) {
                                    listManager.removeFromList(
                                      context
                                          .read<ListManager>()
                                          .completeList!
                                          .items[index],
                                    );
                                  }

                                  if (context.mounted) {
                                    final listManager =
                                        context.read<ListManager>();
                                    listManager.getListItems(
                                      authManager.accessToken,
                                      listManager.completeList!.id,
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                onEdited: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpdateListPage(
                                          list: context
                                              .read<ListManager>()
                                              .completeList!,
                                        );
                                      },
                                    ),
                                  ).then((_) {
                                    if (context.mounted) {
                                      listManager.getLists(
                                        context.read<AuthManager>().accessToken,
                                      );
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
                    : SizedBox(
                        height: 200,
                        child: listManager.lists.isNotEmpty
                            ? Center(
                                child: Text(
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.darkGray),
                                    listManager.completeList != null
                                        ? 'Adicione seu primeiro item!'
                                        : 'Escolha uma lista!'))
                            : const Center(
                                child: Text(
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.darkGray),
                                    'Crie a sua primeira lista!'),
                              ),
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
