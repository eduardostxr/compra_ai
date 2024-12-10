import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/invite_manager.dart';
import 'package:compra/manager/item_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/complete_list_model.dart';
import 'package:compra/ui/home/components/account_bottom_sheet.dart';
import 'package:compra/ui/home/components/general_home_btn.dart';
import 'package:compra/ui/home/components/item_bottom_sheet.dart';
import 'package:compra/ui/home/components/item_description_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_item.dart';
import 'package:compra/ui/home/components/list_manager_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_profile_group.dart';
import 'package:compra/ui/home/components/list_summary.dart';
import 'package:compra/ui/invite/invite_page.dart';
import 'package:compra/ui/new_item/new_item_page.dart';
import 'package:compra/ui/new_list/new_list_page.dart';
import 'package:compra/ui/receipt/receipt_page.dart';
import 'package:compra/ui/update_item/update_item_page.dart';
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
  late CompleteListModel? completeListModel;

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
  final listManager = context.read<ListManager>(); // Obtém sem escutar mudanças
  final inviteManager = context.read<InviteManager>(); // Obtém sem escutar mudanças
  final authManager = context.read<AuthManager>(); // Também sem escutar mudanças

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
                      onPressed: () async {
                        // Aceitar convite
                        await inviteManager.acceptInvite(
                          context,
                          invite.id,
                          true,
                        );

                        // Atualizar informações da lista
                        await listManager.updateListInfo(context);

                        // Obter e configurar listas
                        await listManager.getLists(authManager.accessToken);
                        listManager.setLists(listManager.lists);

                        // Atualizar convites e fechar o modal
                        _fetchInvites();
                        if (mounted) Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () async {
                        // Recusar convite
                        await inviteManager.acceptInvite(
                          context,
                          invite.id,
                          false,
                        );

                        _fetchInvites();
                        if (mounted) Navigator.pop(context);
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
    completeListModel = Provider.of<ListManager>(context).completeList;

    if (completeListModel?.isfinished != null &&
        completeListModel!.isfinished == true) {
      return Consumer<ListManager>(
        builder: (context, listManager, child) {
          return Scaffold(
            backgroundColor: AppColors.offWhite,
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
            body: SafeArea(
              child: Column(
                children: [
                  ListProfileGroupHeader(
                    text: "Minhas Listas",
                    onPressed: () {},
                  ),
                  ListProfileGroup(
                    key: listProfileGroupKey,
                    onAddListTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const NewListPage();
                        },
                      ),
                    ).then((_) {
                      if (context.mounted) {
                        listManager.getLists(
                          context.read<AuthManager>().accessToken,
                        );
                      }
                    }),
                    onProfileTap: (listModel) {
                      listManager.getListItems(
                          context.read<AuthManager>().accessToken,
                          listModel.id);
                    },
                  ),
                  const Divider(
                    endIndent: 16,
                    indent: 16,
                  ),
                  const SizedBox(height: 8),

                  // SingleChildScrollView para permitir rolagem em tudo abaixo do primeiro Divider
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, bottom: 8),
                              child: ListSummary(
                                  completeListModel: completeListModel!),
                            ),
                          ),
                          const Divider(
                            endIndent: 16,
                            indent: 16,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 80.0),
                            itemCount: completeListModel?.items.length ?? 0,
                            itemBuilder: (context, index) {
                              final produto = completeListModel!.items[index];
                              final backgroundColor = index.isEven
                                  ? AppColors.offWhite
                                  : AppColors.lightGray;
                              return ListTile(
                                tileColor: backgroundColor,
                                title: Text(produto.name),
                                subtitle: Text(
                                    'Preço: R\$ ${produto.price.toStringAsFixed(2)}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'Quantidade: ${produto.quantity} ${produto.measurementUnit}'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

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
          child: Column(
            children: [
              // Componentes fora do SingleChildScrollView
              ListProfileGroupHeader(
                text: "Minhas Listas",
                onPressed: () {},
              ),
              ListProfileGroup(
                key: listProfileGroupKey,
                onAddListTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const NewListPage();
                    },
                  ),
                ).then((_) {
                  if (context.mounted) {
                    listManager.getLists(
                      context.read<AuthManager>().accessToken,
                    );
                  }
                }),
                onProfileTap: (listModel) {
                  listManager.getListItems(
                      context.read<AuthManager>().accessToken, listModel.id);
                },
              ),
              const SizedBox(height: 8),
              // Conteúdo que pode rolar
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      listManager.completeList != null
                          ? GeneralHomeBtn(
                              icon: Icons.list_outlined,
                              label: "Gerenciar Lista",
                              onPressed: () {
                                _showBottomSheet(
                                  ListManagerBottomSheet(
                                    onDeleted: () {
                                      listManager
                                          .deleteList(
                                        authManager.accessToken,
                                        listManager.completeList!.id,
                                      )
                                          .then((_) {
                                        setState(() {
                                          listManager.getLists(
                                              authManager.accessToken);
                                          listProfileGroupKey.currentState
                                              ?.resetSelection();
                                        });
                                      });
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
                                              context
                                                  .read<AuthManager>()
                                                  .accessToken,
                                            );
                                          }
                                        },
                                      );
                                    },
                                    onInvited: () {
                                      final listId =
                                          listManager.completeList!.id;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InvitePage(listId: listId),
                                        ),
                                      ).then((_) {
                                        if (context.mounted) {
                                          listManager.getLists(
                                            context
                                                .read<AuthManager>()
                                                .accessToken,
                                          );
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Convite enviado."),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        }
                                      });
                                    },
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
                                        listId: listManager.completeList!.id,
                                      );
                                    },
                                  ),
                                ).then((_) {
                                  if (context.mounted) {
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
                                            builder: (context) =>
                                                UpdateItemPage(
                                              item: context
                                                  .read<ListManager>()
                                                  .completeList!
                                                  .items[index],
                                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
