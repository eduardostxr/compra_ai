import 'package:compra/manager/item_manager.dart';
import 'package:compra/models/item_model.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';

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
    final double? quantity = double.tryParse(quantityController.text);

    setState(() {
      _isButtonEnabled = name.isNotEmpty && quantity != null && quantity > 0;
    });
  }

  void _updateItem() async {
  try {
    final String name = nameController.text.trim();
    final double? quantity = double.tryParse(quantityController.text);
    final double? price = double.tryParse(priceController.text);
    final String? description = descriptionController.text.trim().isEmpty
        ? null
        : descriptionController.text;

    final ItemManager itemManager = ItemManager(context);

    await itemManager.updateItem(
      itemId: widget.item.id,
      name: name,
      quantity: quantity!,
      price: price,
      description: description,
    );
    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erro ao atualizar o item: $e")),
    );
  }
}


  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.item.name.isNotEmpty == true ? widget.item.name : "",
    );
    quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    priceController = TextEditingController(
      text: widget.item.price != null ? widget.item.price.toString() : "",
    );
    descriptionController = TextEditingController(
      text: widget.item.description?.isNotEmpty == true
          ? widget.item.description
          : "",
    );

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
              label: "Editar",
              onPressed: _isButtonEnabled ? _updateItem : () {},
            ),
          ],
        ),
      ),
    );
  }
}
