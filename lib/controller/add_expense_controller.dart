import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/item_model.dart';
import '../views/expense/add_item_screen.dart';

class AddExpenseController extends GetxController {
  final categoryController = TextEditingController();
  final vendorController = TextEditingController();
  final totalBillingController = TextEditingController(text: "0.00");
  final paidController = TextEditingController(text: "0.00");

  RxList<ItemModel> items = <ItemModel>[].obs;
  RxString selectedPayment = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  List<String> paymentModes = ['Cash', 'UPI', 'Card', 'NEFT', 'RTGS'];

  String get formattedDate =>
      DateFormat('dd-MMMM-yyyy').format(selectedDate.value);

  void pickDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) selectedDate.value = picked;
  }

  void openAddItemSheet() {
    Get.bottomSheet(AddItemSheet(controller: this));
  }

  void submitExpense() {
    Get.snackbar("Submitted", "Expense recorded successfully");
  }
}
