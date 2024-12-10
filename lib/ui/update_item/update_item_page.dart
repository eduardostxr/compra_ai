import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/item_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/item_model.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateItemPage extends StatefulWidget {
  final ItemModel item;
  const UpdateItemPage({super.key, required this.item});

  @override
  State<UpdateItemPage> createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  late final TextEditingController nameController;
  late final TextEditingController quantityController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  bool _isButtonEnabled = true;

  void _validateInputs() {
    final String name = nameController.text.trim();

    setState(() {
      _isButtonEnabled = name.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.item.name.isNotEmpty ? widget.item.name : "",
    );
    quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    priceController = TextEditingController(
      text: widget.item.price.toString(),
    );
    descriptionController = TextEditingController(
      text: widget.item.description?.isNotEmpty == true
          ? widget.item.description
          : "",
    );

    nameController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ItemManager, AuthManager, ListManager>(
      builder: (context, itemManager, authManager, listManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Editar Item"),
            foregroundColor: AppColors.offWhite,
            backgroundColor: AppColors.orange,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                const GenericPageHeader(
                  title: "",
                  subtitle: "Dê um nome para o item e a observação é opcional.",
                ),
                const SizedBox(height: 16),
                InputField(
                  hint: "Ex: Banana",
                  label: "Item",
                  controller: nameController,
                ),
                InputField(
                  hint: "Ex: A marca tal",
                  label: "Observação",
                  controller: descriptionController,
                  moreLines: true,
                ),
                const SizedBox(height: 32),
                DefaultButton(
                  color: _isButtonEnabled
                      ? AppColors.darkGreen
                      : AppColors.mediumGray,
                  label: "Editar",
                  onPressed: () async {
                    final response = await itemManager.updateItem(
                      itemId: widget.item.id,
                      name: nameController.text,
                      quantity: double.tryParse(quantityController.text) ?? 0,
                      price: priceController.text.isNotEmpty
                          ? double.tryParse(priceController.text)
                          : null,
                      description: descriptionController.text,
                      token: authManager.accessToken,
                    );

                    if (response != null &&
                        response.statusCode >= 200 &&
                        response.statusCode < 300) {
                      await listManager.getListItems(authManager.accessToken,
                          listManager.completeList!.id);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Falha ao atualizar o item.')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
