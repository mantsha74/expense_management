import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/add_expense_controller.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddExpenseController controller = Get.find<AddExpenseController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Expense"),
        foregroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _label("Date *"),
            InkWell(
              onTap: controller.pickDate,
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(controller.formattedDate),
                      const Spacer(),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            _label("Category Name *"),
            TextField(
              controller: controller.categoryController,
              decoration: const InputDecoration(
                hintText: "Please type here",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            _label("Vendor Name (optional)"),
            TextField(
              controller: controller.vendorController,
              decoration: const InputDecoration(
                hintText: "e.g. Big Basket",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: controller.openAddItemSheet,
              icon: const Icon(Icons.add),
              label: const Text("Add Item"),
            ),

            const SizedBox(height: 16),

            Obx(
              () => Column(
                children: controller.items.map((item) {
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('${item.quantity} ${item.unit}'),
                    trailing: Text('₹${item.price.toStringAsFixed(2)}'),
                  );
                }).toList(),
              ),
            ),

            const Divider(height: 32),

            _amountRow(
              "Total Billing",
              controller.totalBillingController,
              Colors.blue,
            ),
            const Divider(),
            _amountRow("Paid", controller.paidController, Colors.green),

            const SizedBox(height: 16),
            _label("Mode of Payment *"),
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedPayment.value.isEmpty
                    ? null
                    : controller.selectedPayment.value,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text("Please Select"),
                items: controller.paymentModes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) =>
                    controller.selectedPayment.value = value ?? '',
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: controller.submitExpense,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Submit",),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _amountRow(
    String label,
    TextEditingController controller,
    Color color,
  ) {
    return Row(
      children: [
        Text(label),
        const Spacer(),
        Text("₹", style: TextStyle(color: color)),
        const SizedBox(width: 4),
        SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(border: InputBorder.none),
            style: TextStyle(color: color),
          ),
        ),
      ],
    );
  }
}
