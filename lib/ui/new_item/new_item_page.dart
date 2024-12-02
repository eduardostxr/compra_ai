import 'package:compra/manager/item_manager.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

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
    final double? quantity = double.tryParse(quantityController.text);

    setState(() {
      _isButtonEnabled = name.isNotEmpty && quantity != null && quantity > 0;
    });
  }

  void _createItem() {
    final String name = nameController.text.trim();
    final double? quantity = quantityController.text.isNotEmpty
        ? double.tryParse(quantityController.text)
        : null;
    final double? price = double.tryParse(priceController.text);
    final String? description = descriptionController.text.trim().isEmpty
        ? null
        : descriptionController.text;

    final ItemManager itemManager = ItemManager(context);

    itemManager.createItem(
      listId: widget.listId,
      name: name,
      quantity: quantity!,
      price: price,
      description: description,
    );

    nameController.clear();
    quantityController.clear();
    priceController.clear();
    descriptionController.clear();
    _validateInputs();
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
    return Scaffold(
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
              hint: "Ex: 5",
              label: "Quantidade",
              controller: quantityController,
              keyboardType: TextInputType.number,
            ),
            InputField(
              hint: "Ex: 50.50",
              label: "Preço",
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
            InputField(
              hint: "Ex: A marca tal",
              label: "Observação",
              controller: descriptionController,
              moreLines: true,
            ),
            const SizedBox(height: 32),
            DefaultButton(
              color:
                  _isButtonEnabled ? AppColors.darkGreen : AppColors.mediumGray,
              label: "Adicionar",
              onPressed: _isButtonEnabled ? _createItem : () {},
            ),
          ],
        ),
      ),
    );
  }
}
