import 'package:expense_manager/modules/dashboard/dashboard_page_controller.dart';
import 'package:expense_manager/modules/dashboard/widgets/build_status_button.dart';
import 'package:expense_manager/modules/dashboard/widgets/expense_carrousel.dart';
import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/modules/expenses/widgets/expense_details.dart';
import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
//import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardPageController());

    return Scaffold(
      // Couleur de la page
      backgroundColor: Colors.grey[100],

      //Entête
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/somimas.jpg',
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "SOMIMAS",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white24,
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  Get.toNamed('/notifications');
                },
              ),
            ),
          )
        ],
      ),

      body: Obx(() {
        final expensesList = controller.expenses;
        final pendingExpenses = controller.pendingExpenses;
        final totalAmount = controller.totalAmount;
        //final statusCounts = controller.getStatusCounts();
        //final categoryData = controller.getCategoryData();

        return SingleChildScrollView(
          child: Column(
            children: [
              // Partie haute de la page (total et boutons)
              Stack(
                children: [
                  Container(
                    color: AppColors.primary,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 0, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Résumé des dépenses du mois",
                                style: TextStyle(color: Colors.white),
                              ),
                              //SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.account_balance_wallet,
                                      color: Colors.white, size: 28),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        controller.isAmountVisible.value
                                            ? "Total: ${NumberFormat.currency(
                                                locale: 'fr_FR',
                                                symbol: 'Fcfa',
                                                decimalDigits: 0,
                                              ).format(totalAmount)}"
                                            : "Total: ******* Fcfa",
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      controller.isAmountVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed:
                                        controller.toggleAmountVisibility,
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Icon(Icons.account_balance_wallet,
                              //         color: Colors.white, size: 28),
                              //     SizedBox(width: 4),
                              //     Text(
                              //       controller.isAmountVisible.value
                              //           ? "Total: ${NumberFormat.currency(
                              //               locale: 'fr_FR',
                              //               symbol: 'Fcfa',
                              //               decimalDigits: 0,
                              //             ).format(totalAmount)}"
                              //           : "Total: ******* Fcfa",
                              //       style: TextStyle(
                              //         fontSize: 20,
                              //         height: 0,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     //SizedBox(width: 2),
                              //     IconButton(
                              //       icon: Icon(
                              //         controller.isAmountVisible.value
                              //             ? Icons.visibility
                              //             : Icons.visibility_off,
                              //         color: Colors.white,
                              //       ),
                              //       onPressed:
                              //           controller.toggleAmountVisibility,
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: 35),
                            ],
                          ),
                        ),
                        Container(height: 50, color: Colors.grey[100]),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 16,
                    right: 16,
                    child: BuildStatusButtons(
                      statusCounts: controller.getStatusCounts(),
                      onStatusSelected: controller.updateSelectedStatus,
                      iconSize: 16,
                      containerPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    ),
                  ),
                ],
              ),
              // Partie basse
              Container(
                color: Colors.grey[100],
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Text(
                    //   "Répartition par catégorie",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //     color: AppColors.primary,
                    //   ),
                    // ),
                    // SizedBox(height: 24),
                    // SizedBox(
                    //   height: 150,
                    //   child: PieChart(
                    //     PieChartData(
                    //       sections: categoryData,
                    //       borderData: FlBorderData(show: false),
                    //       sectionsSpace: 2,
                    //       centerSpaceRadius: 20,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Dépenses du mois par catégorie",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),

                    Center(
                        child: ExpenseCarousel3(
                      expenses: expensesList,
                      // onTap: (expense) =>
                      //     _showExpenseDetails(context, expense, controller),
                    )),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Dernières dépenses",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Center(
                        child: ExpenseCarousel2(
                      expenses: pendingExpenses,
                      onTap: (expense) => _showExpenseDetails(context, expense),
                    )),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Widget _buildStatusBadge(String status, int count, Color color) {
  //   return Container(
  //     height: 70,
  //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Text(
  //       "$status: \n$count",
  //       style: TextStyle(color: color, fontSize: 14),
  //     ),
  //   );
  // }

  void _showExpenseDetails(BuildContext context, Expense expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ExpenseDetails(
          expense: expense,
        );
      },
    );
  }
}
