import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/expense_controller.dart';
import '../../routes/app_routes.dart';

class SalesExpenseScreen extends StatelessWidget {
  final ExpenseController controller = Get.put(ExpenseController());
  final TextEditingController textController = TextEditingController();

  SalesExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sales & Expense")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                _TabChip(label: 'Sales', selected: false),
                _TabChip(label: 'Expense', selected: true),
                _TabChip(label: 'Money Management', selected: false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type here to add more category',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    controller.addCategory(textController.text);
                    textController.clear();
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final cat = controller.categories[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  child: ListTile(
                    leading:
                    const Icon(Icons.category, color: Colors.green),
                    title: Text(cat),
                    trailing:
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addExpense),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.pink.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
              color: selected ? Colors.pink : Colors.black,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
