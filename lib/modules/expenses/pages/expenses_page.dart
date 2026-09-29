import 'package:expense_manager/config/colors.dart';
import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/modules/expenses/controllers/expenses_page_controller.dart';
import 'package:expense_manager/modules/expenses/widgets/build_tab_button.dart';
import 'package:expense_manager/modules/expenses/widgets/expense_details.dart';
import 'package:expense_manager/modules/expenses/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Injecter le contrôleur
    final ExpensesController controller = Get.put(ExpensesController());

    return Obx(() => Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: const Text(
              "Dépenses du mois",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.filter_list, color: Colors.white),
            //     onPressed: () => _showRightSheet(context),
            //   ),
            // ],
          ),
          body: Column(
            children: [
              // Partie haute
              Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Text(
                        "Total: ${NumberFormat.currency(
                          locale: 'fr_FR',
                          symbol: 'FCFA',
                          decimalDigits: 0,
                        ).format(controller.totalAmount)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BuildTabButton(
                          label: "Toutes",
                          count: "${controller.expenses.length}",
                          isSelected: controller.currentFilter == "Toutes",
                          onPressed: () => controller.currentFilter = "Toutes",
                        ),
                        BuildTabButton(
                          label: "En attente",
                          count: "${controller.statusCounts["En attente"] ?? 0}",
                          isSelected: controller.currentFilter == "En attente",
                          onPressed: () =>
                              controller.currentFilter = "En attente",
                        ),
                        BuildTabButton(
                          label: "Validées",
                          count: "${controller.statusCounts["Approuvée"] ?? 0}",
                          isSelected: controller.currentFilter == "Validées",
                          onPressed: () => controller.currentFilter = "Validées",
                        ),
                        BuildTabButton(
                          label: "Rejetées",
                          count: "${controller.statusCounts["Rejetée"] ?? 0}",
                          isSelected: controller.currentFilter == "Rejetées",
                          onPressed: () => controller.currentFilter = "Rejetées",
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
              // Partie basse
              Expanded(
                child: _buildExpenseList(context, controller.filteredExpenses),
              ),
            ],
          ),
        ));
  }

  Widget _buildExpenseList(BuildContext context, List<Expense> expenses) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8.0),
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ExpenseItem(
            expense: expense,
            onTap: (expense) => _showExpenseDetails(context, expense),
          );
        },
      ),
    );
  }

  void _showExpenseDetails(BuildContext context, Expense expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ExpenseDetails(expense: expense);
      },
    );
  }

  // void _showRightSheet(BuildContext context) {
  //   final controller = Get.find<ExpensesController>();
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: '',
  //     transitionDuration: const Duration(milliseconds: 300),
  //     pageBuilder: (context, animation, secondaryAnimation) {
  //       return Align(
  //         alignment: Alignment.centerRight,
  //         child: Material(
  //           color: Colors.transparent,
  //           child: Container(
  //             margin:
  //                 EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
  //             width: MediaQuery.of(context).size.width * 0.8,
  //             height: double.infinity,
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20),
  //                 bottomLeft: Radius.circular(0),
  //               ),
  //             ),
  //             child: RightSheetContent(
  //               onFiltersApplied: (filters) {
  //                 controller.applyAdvancedFilters(filters);
  //               },
  //               initialFilters: controller.advancedFilters,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //     transitionBuilder: (context, animation, secondaryAnimation, child) {
  //       return SlideTransition(
  //         position: Tween<Offset>(
  //           begin: const Offset(1, 0),
  //           end: Offset.zero,
  //         ).animate(CurvedAnimation(
  //           parent: animation,
  //           curve: Curves.easeOutQuart,
  //         )),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}