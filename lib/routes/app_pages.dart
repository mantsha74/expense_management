import 'package:get/get.dart';
import '../binding/add_expense_binding.dart';
import '../views/home/sales_expense_screen.dart';
import '../views/expense/add_expense_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => SalesExpenseScreen(),
    ),
    GetPage(
      name: AppRoutes.addExpense,
      page: () => const AddExpenseScreen(),
      binding: AddExpenseBinding(),
    ),
  ];
}
