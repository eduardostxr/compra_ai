import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/item_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/manager/user_manager.dart';
import 'package:compra/models/complete_list_model.dart';
import 'package:compra/models/item_model.dart';
import 'package:compra/models/list_model.dart';
import 'package:compra/ui/home/components/account_bottom_sheet.dart';
import 'package:compra/ui/home/components/add_list_button.dart';
import 'package:compra/ui/home/components/item_bottom_sheet.dart';
import 'package:compra/ui/home/components/list_item.dart';
import 'package:compra/ui/home/components/list_profile.dart';
import 'package:compra/ui/new_item/new_item_page.dart';
import 'package:compra/ui/update_item/update_item_page.dart';
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
  List<ListModel> lists = [];
  ListModel? chosenList;
  CompleteListModel? completeList;
  String userName = "Usuário";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chosenList = context.read<ListManager>().selectedList;
    if (chosenList != null) {
      _fetchListItems(chosenList!);
    }
    _fetchUserName();
    _fetchLists();
  }

  void _fetchUserName() async {
    final authManager = Provider.of<AuthManager>(context, listen: false);
    final userManager = Provider.of<UserManager>(context, listen: false);

    final token = authManager.accessToken;
    if (token.isNotEmpty) {
      final response = await userManager.getMe(context);
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
            lists = data.map((json) => ListModel.fromJson(json)).toList();
          });
        }
      }
    } catch (error) {
      debugPrint("Error fetching lists: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _fetchListItems(ListModel profile) async {
    try {
      final authManager = Provider.of<AuthManager>(context, listen: false);
      final listManager = ListManager(context);

      final token = authManager.accessToken;
      if (token.isNotEmpty) {
        final response = await listManager.getListItems(profile.id);
        debugPrint("Response for profile ID ${profile.id}: $response");

        if (response != null && response.statusCode == 200) {
          final data = response.value;

          if (data is Map<String, dynamic>) {
            setState(() {
              completeList = CompleteListModel.fromJson(data);
            });
            debugPrint(
                "Complete list fetched successfully: ${completeList?.name}");
          } else {
            debugPrint("Unexpected data type: ${data.runtimeType}");
          }
        }
      }
    } catch (error) {
      debugPrint("Error fetching complete list: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _checkItem(ItemModel item) async {
    ItemModel retorno = item;
    try {
      final authManager = Provider.of<AuthManager>(context, listen: false);
      final itemManager = ItemManager(context);

      final token = authManager.accessToken;
      if (token.isNotEmpty) {
        final response = await itemManager.checkItem(itemId: item.id);

        debugPrint("Response for item ID ${item.id}: $response");

        if (response != null && response.statusCode == 200) {
          retorno = ItemModel.fromJson(response.value);
          setState(() {
            final index = completeList!.items
                .indexWhere((element) => element.id == item.id);
            if (index != -1) {
              completeList!.items[index].checked =
                  !completeList!.items[index].checked;
            }
            completeList!.items[index].checked = retorno.checked;
          });
          debugPrint("Item ${item.id} atualizado com sucesso!");
        } else {
          debugPrint("Falha ao marcar/desmarcar o item.");
        }
      }
    } catch (error) {
      debugPrint("Erro ao atualizar o status do item: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return retorno.checked;
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

  void _showItemBottomSheet(Widget bottomSheetWidget) {
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

  void _deleteItem(ItemModel item) async {
    try {
      final authManager = Provider.of<AuthManager>(context, listen: false);
      final itemManager = ItemManager(context);

      final token = authManager.accessToken;
      if (token.isNotEmpty) {
        final response = await itemManager.deleteItem(itemId: item.id);

        debugPrint("Response for item ID ${item.id}: $response");

        if (response != null && response.statusCode == 204) {
          setState(() {
            completeList!.items.removeWhere((element) => element.id == item.id);
          });
          debugPrint("Item ${item.id} deletado com sucesso!");
        } else {
          debugPrint("Falha ao deletar o item.");
        }
      }
    } catch (error) {
      debugPrint("Erro ao deletar o item: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
              textAlign: TextAlign.left,
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  ListProfileGroupHeader(
                    text: lists.isNotEmpty
                        ? "Minhas Listas"
                        : "Adicione sua primeira lista tocando no botão abaixo!",
                    onPressed: () {},
                  ),
                  ListProfileGroup(
                    profiles: lists,
                    onProfileTap: (index, profile) {
                      _fetchListItems(profile);
                      context.read<ListManager>().selectedList = profile;
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          if (lists.isNotEmpty) ...[
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewItemPage(
                                      listId: completeList!.id,
                                    ),
                                  ),
                                ).then((value) {
                                  if (chosenList != null) {
                                    _fetchListItems(chosenList!);
                                  }
                                });
                              },
                            ),
                            completeList != null &&
                                    completeList!.items.isNotEmpty
                                ? ListView.builder(
                                    itemBuilder: (context, index) => ListItem(
                                      item: completeList!.items[index],
                                      onInfoPressed: () {},
                                      onMorePressed: () {
                                        _showItemBottomSheet(
                                          ItemBottomSheet(
                                            title:
                                                completeList!.items[index].name,
                                            onDeleted: () {
                                              _deleteItem(
                                                  completeList!.items[index]);
                                              Navigator.pop(context);
                                            },
                                            onEdited: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateItemPage(
                                                    item: completeList!
                                                        .items[index],
                                                  ),
                                                ),
                                              ).then((value) {
                                               
                                                  setState(() {
                                                    // final index = completeList!
                                                    //     .items
                                                    //     .indexWhere((item) =>
                                                    //         item.id ==
                                                    //         value.id);
                                                    // if (index != -1) {
                                                    //   completeList!
                                                    //       .items[index] = value;
                                                    // }
                                                  });
                                                
                                              
                                              });
                                      }),
                                        );
                                      },
                                      onChecked: (bool checked) async {
                                        await _checkItem(
                                            completeList!.items[index]);
                                        setState(() {
                                          completeList!.items[index].checked =
                                              checked;
                                        });
                                      },
                                    ),
                                    itemCount: completeList!.items.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                  )
                                : const SizedBox.shrink(),
                          ],
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
