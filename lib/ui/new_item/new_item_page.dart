import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/item_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewItemPage extends StatefulWidget {
  final int listId;
  const NewItemPage({super.key, required this.listId});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  late final TextEditingController nameController;
  late final TextEditingController quantityController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  bool _isButtonEnabled = false;

  void _validateInputs() {
    final String name = nameController.text.trim();
    // final double? quantity = double.tryParse(quantityController.text);

    setState(() {
      _isButtonEnabled = name.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    quantityController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    nameController.addListener(_validateInputs);
    quantityController.addListener(_validateInputs);
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
    return Consumer3<ItemManager, ListManager, AuthManager>(
      builder: (context, itemManager, listManager, authManager, child) =>
          Scaffold(
        appBar: AppBar(
          title: const Text("Novo Item"),
          foregroundColor: AppColors.offWhite,
          backgroundColor: AppColors.orange,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const GenericPageHeader(
                title: "",
                subtitle: "Dê um nome para o item e o restante é opcional.",
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
                label: "Adicionar",
                onPressed: _isButtonEnabled
                    ? () async {
                        final double? quantity =
                            quantityController.text.isNotEmpty
                                ? double.tryParse(quantityController.text)
                                : 0;

                        final double? price = priceController.text.isNotEmpty
                            ? double.tryParse(priceController.text)
                            : 0;

                        if (quantityController.text.isNotEmpty &&
                            quantity == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Quantidade inválida.')),
                          );
                          return;
                        }

                        final item = await itemManager.createItem(
                          context: context,
                          listId: widget.listId,
                          name: nameController.text,
                          quantity: quantity,
                          price: price,
                          description: descriptionController.text,
                        );

                        if (item != null) {
                          listManager.addNewItem(item);
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Falha ao criar o item.')),
                          );
                        }
                      }
                    : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
