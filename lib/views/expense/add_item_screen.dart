import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/add_expense_controller.dart';
import '../../models/item_model.dart';

class AddItemSheet extends StatelessWidget {
  final AddExpenseController controller;
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  final priceController = TextEditingController();
  final RxString selectedUnit = ''.obs;

  AddItemSheet({super.key, required this.controller});

  final List<String> units = ['KG', 'Litre', 'Piece', 'Gram'];

  void saveItem({bool clear = false}) {
    if (nameController.text.isNotEmpty &&
        qtyController.text.isNotEmpty &&
        selectedUnit.value.isNotEmpty &&
        priceController.text.isNotEmpty) {
      controller.items.add(
        ItemModel(
          name: nameController.text,
          quantity: qtyController.text,
          unit: selectedUnit.value,
          price: double.tryParse(priceController.text.replaceAll(',', '')) ?? 0.0,
        ),
      );
      if (clear) {
        nameController.clear();
        qtyController.clear();
        priceController.clear();
        selectedUnit.value = '';
      } else {
        Get.back();
      }
    } else {
      Get.snackbar("Error", "Please fill all required fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Total Quantity Purchased ",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() => DropdownButtonFormField<String>(
                    value: selectedUnit.value.isEmpty ? null : selectedUnit.value,
                    decoration: const InputDecoration(
                      labelText: "Quantity Type",
                      border: OutlineInputBorder(),
                    ),
                    items: units
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => selectedUnit.value = val ?? '',
                  )),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Total Item Pricing",
                prefixText: "₹ ",
                border: OutlineInputBorder(),
              ),
            ),
            const Divider(height: 24),
            // Save & New
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => saveItem(clear: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Save & New"),
              ),
            ),
            const SizedBox(height: 8),
            // Save
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => saveItem(clear: false),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Save"),
              ),
            ),
            const SizedBox(height: 8),
            // Cancel
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Cancel"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
