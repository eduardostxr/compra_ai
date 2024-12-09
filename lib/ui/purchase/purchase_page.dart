import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/purchase.dart';
import 'package:compra/ui/_common/custom_bottom_sheet.dart';
import 'package:compra/ui/_common/sheet_button.dart';
import 'package:compra/ui/home/home_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class PurchaseItemsPage extends StatelessWidget {
  const PurchaseItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final purchase = Provider.of<ListManager>(context).purchase;

    if (purchase == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.orange,
          foregroundColor: AppColors.white,
          title: const Text('Itens da Nota'),
          automaticallyImplyLeading: false,
        ),
        body: const Center(child: Text('Nenhuma compra encontrada.')),
      );
    }

    return Consumer<ListManager>(builder: (context, listManager, child) {
      return Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          backgroundColor: AppColors.orange,
          title: const Text('Itens da Nota'),
          automaticallyImplyLeading: false,
          foregroundColor: AppColors.white,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80.0),
          itemCount: purchase.payload.produtos.length,
          itemBuilder: (context, index) {
            final produto = purchase.payload.produtos[index];
            final backgroundColor =
                index.isEven ? AppColors.offWhite : AppColors.lightGray;
            return ListTile(
              tileColor: backgroundColor,
              title: Text(produto.name),
              subtitle: Text('Preço: R\$ ${produto.price}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Quantidade: ${produto.quantity} ${produto.measurementUnit}'),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      _showBottomSheet(context, produto, index, listManager);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: AppColors.lightPeach,
          foregroundColor: AppColors.mediumGray,
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(
              label: 'Adicionar',
              child: const Icon(Icons.add),
              backgroundColor: Colors.green,
              foregroundColor: AppColors.darkGray,
              onTap: () {
                _showAddItemDialog(context, listManager);
              },
            ),
            SpeedDialChild(
              label: 'Confirmar',
              child: const Icon(Icons.check),
              backgroundColor: Colors.blue,
              foregroundColor: AppColors.darkGray,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Itens confirmados!')),
                );
              },
            ),
            SpeedDialChild(
              label: 'Cancelar',
              child: const Icon(Icons.cancel),
              backgroundColor: Colors.red,
              foregroundColor: AppColors.darkGray,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      );
    });
  }

  void _showBottomSheet(BuildContext context, Product produto, int index,
      ListManager listManager) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return CustomBottomSheet(title: produto.name, children: [
          SheetButton(
            icon: Icons.edit_outlined,
            color: AppColors.darkGray,
            label: "Editar Item",
            onPressed: () {
              _showEditItemDialog(context, produto, index, listManager);
            },
          ),
          const Divider(
            height: 32,
          ),
          SheetButton(
            icon: Icons.delete_forever_outlined,
            color: Colors.red,
            label: "Deletar Item",
            onPressed: () {
              listManager.removePurchaseProduct(produto);
              Navigator.of(context).pop();
            },
          ),
        ]);
      },
    );
  }

  void _showEditItemDialog(BuildContext context, Product produto, int index,
      ListManager listManager) {
    final nameController = TextEditingController(text: produto.name);
    final priceController =
        TextEditingController(text: produto.unitPrice.toString());
    final quantityController =
        TextEditingController(text: produto.quantity.toString());
    final unitController = TextEditingController(text: produto.measurementUnit);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Editar Item'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: 'Nome do Produto'),
                ),
                TextField(
                  controller: priceController,
                  decoration:
                      const InputDecoration(labelText: 'Preço (unidade)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Unidade'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final price = double.tryParse(priceController.text) ?? 0.0;
                  final quantity =
                      double.tryParse(quantityController.text) ?? 0;
                  final unit = unitController.text;

                  listManager.updatePurchaseProduct(
                    Product(
                      name: name,
                      quantity: quantity,
                      unitPrice: price,
                      price: price * quantity,
                      measurementUnit: unit,
                    ),
                    index,
                  );

                  Navigator.of(context).pop();
                },
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context, ListManager listManager) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();
    final unitController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Novo Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: 'Nome do Produto'),
                ),
                TextField(
                  controller: priceController,
                  decoration:
                      const InputDecoration(labelText: 'Preço (unidade)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Unidade'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final price = double.tryParse(priceController.text) ?? 0.0;
                final quantity = double.tryParse(quantityController.text) ?? 0;
                final unit = unitController.text;

                listManager.addPurchaseProduct(
                  Product(
                    name: name,
                    quantity: quantity,
                    unitPrice: price,
                    price: double.parse((price * quantity).toStringAsFixed(2)),
                    measurementUnit: unit,
                  ),
                );

                Navigator.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
