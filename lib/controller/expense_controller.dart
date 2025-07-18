import 'package:get/get.dart';

class ExpenseController extends GetxController {
  var categories = [
    "Salaries",
    "Fixed Expense",
    "Dairy",
    "Grocery",
    "Cleaning Supplies",
    "Kitchen Grocery",
    "Laundry",
    "Utility Bills",
  ].obs;

  void addCategory(String category) {
    if (category.trim().isNotEmpty) {
      categories.add(category);
    }
  }
}
