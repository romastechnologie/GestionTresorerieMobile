import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/config/colors.dart';
import 'package:expense_manager/modules/expenses/widgets/expense_details.dart';
import 'package:expense_manager/modules/expenses/widgets/expense_item.dart';
import 'package:expense_manager/modules/history/widgets/content_filters.dart';
import 'package:expense_manager/modules/history/controllers/history_controller.dart';
import 'package:expense_manager/modules/history/controllers/tab_controller_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Injecter les contrôleurs
    final HistoryController controller = Get.put(HistoryController());
    final TabControllerManager tabControllerManager = Get.put(TabControllerManager());

    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: const Text(
              "Historique",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            actions: [

              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () => _showFilterBottomSheet(context),
              ),
            ],
          ),
          backgroundColor: Colors.grey[100],
          body: Column(
            children: [
              // Partie haute
              Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    // Center(
                    //   child: TextButton(
                    //     onPressed: controller.resetFilters,
                    //     child: const Text(
                    //       "Réinitialiser filtres",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         decoration: TextDecoration.underline,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                                                //_buildCategoryFilter(controller),

                                                _buildTimeFilter(controller),

                        TextButton(
                        onPressed: controller.resetFilters,
                        child: const Text(
                          "Réinitialiser filtres",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    
                      ],
                    ),
                    PreferredSize(
                      preferredSize: const Size.fromHeight(48.0),
                      child: TabBar(
                        controller: tabControllerManager.tabController,
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white54,
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(text: "Toutes (${controller.allFilteredExpenses.length})"),
                          Tab(text: "Validées (${controller.statusCounts["Approuvée"] ?? 0})"),
                          Tab(text: "Rejetées (${controller.statusCounts["Rejetée"] ?? 0})"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Partie basse
              Expanded(
  child: TabBarView(
    controller: tabControllerManager.tabController,
    children: [
      // Toutes les dépenses
      _buildExpenseList(context, controller.filteredExpenses),
      // Dépenses validées
      _buildExpenseList(context, controller.filteredExpenses, status: "Approuvée"),
      // Dépenses rejetées
      _buildExpenseList(context, controller.filteredExpenses, status: "Rejetée"),
    ],
  ),
),
              // Contrôles de pagination
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Page ${controller.currentPage} de ${controller.totalPages}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: controller.currentPage > 1 ? controller.previousPage : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: controller.currentPage < controller.totalPages ? controller.nextPage : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  // Widget _buildCategoryFilter(HistoryController controller) {
  //   return Center(
  //     child: Container(
  //       width: 0.4 * Get.width,
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: AppColors.primary),
  //       ),
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton<String>(
  //           isExpanded: false,
  //           dropdownColor: Colors.white,
  //           value: controller.selectedCategory,
  //           icon: Icon(Icons.arrow_drop_down, color: AppColors.primary),
  //           items: controller.categories.map((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(
  //                 value,
  //                 style: TextStyle(
  //                   color: AppColors.primary,
  //                   fontWeight: value == controller.selectedCategory ? FontWeight.bold : FontWeight.normal,
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (newValue) {
  //             controller.selectedCategory = newValue!;
  //           },
  //           selectedItemBuilder: (BuildContext context) {
  //             return controller.categories.map((String value) {
  //               return Center(
  //                 child: Text(
  //                   value,
  //                   style: TextStyle(
  //                     color: AppColors.primary,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               );
  //             }).toList();
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTimeFilter(HistoryController controller) {
    return Center(
      child: Container(
        width: 0.5* Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            value: controller.selectedTimeFilter,
            icon: Icon(Icons.arrow_drop_down, color: AppColors.primary),
            items: controller.timeFilters.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: value == controller.selectedTimeFilter ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              controller.selectedTimeFilter = newValue!;
            },
            selectedItemBuilder: (BuildContext context) {
              return controller.timeFilters.map((String value) {
                return Center(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseList(BuildContext context, List<Expense> expenses, {String? status}) {
  // Filtrer par statut si spécifié
  final filteredExpenses = status != null
      ? expenses.where((expense) => expense.status == status).toList()
      : expenses;

  return Container(
    color: Colors.grey[100],
    padding: const EdgeInsets.only(left: 8, right: 8, top: 8.0),
    child: ListView.builder(
      itemCount: filteredExpenses.length,
      itemBuilder: (context, index) {
        final expense = filteredExpenses[index];
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


  void _showFilterBottomSheet(BuildContext context) {
    final controller = Get.find<HistoryController>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: ContentFilters(
                  onFiltersApplied: (filters) {
                    controller.applyAdvancedFilters(filters);
                    Navigator.pop(context);
                  },
                  initialFilters: controller.advancedFilters,
                ),
              ),
            );
          },
        );
      },
    );
  }
}