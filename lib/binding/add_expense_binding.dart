import 'package:get/get.dart';
import '../controller/add_expense_controller.dart';
class AddExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddExpenseController());
  }
}
