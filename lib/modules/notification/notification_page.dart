import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/modules/notification/notification_item.dart';
import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'notification_page_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationPageController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text(
          "Dépenses en attente",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        final pendingExpenses = controller.pendingExpenses;

        return pendingExpenses.isEmpty
            ? SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height *0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar( backgroundColor: Colors.grey[100], radius: 30, child: Icon(Icons.notifications_off, size: 40, color: AppColors.primary,)),
                  SizedBox(height: 20,),
                  Text(
                    "Aucune dépense en attente",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: pendingExpenses.length,
                itemBuilder: (context, index) {
                  final expense = pendingExpenses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: NotificationItem(
                      expense: expense,
                      onTap: (expense) => _showExpenseDetails(context, expense, controller),
                    ),
                  );
                },
              );
      }),
    );
  }

  void _showExpenseDetails(BuildContext context, Expense expense, NotificationPageController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[100],
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.primary,
              ),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  expense.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 3,
                  ),
                ),
              ),
            ),
            const Divider(thickness: 1, color: Colors.grey, height: 2),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• Montant: ${NumberFormat.currency(
                      locale: 'fr_FR',
                      symbol: 'FCFA',
                      decimalDigits: 0,
                    ).format(expense.amount)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "• Catégorie: ${expense.category}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "• Date: ${DateFormat('dd/MM/yyyy').format(expense.date)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "• Motif: ${expense.motif}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text("Confirmer", textAlign: TextAlign.center),
                          content: const Text("Voulez-vous rejeter cette dépense ?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Non"),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.updateExpenseStatus(expense, "Rejetée");
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Oui",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      minimumSize: Size(0.48 * MediaQuery.of(context).size.width, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Rejeter",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text("Confirmer", textAlign: TextAlign.center),
                          content: const Text("Voulez-vous approuver cette dépense ?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Non"),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.updateExpenseStatus(expense, "Approuvée");
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Oui",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green),
                      minimumSize: Size(0.48 * MediaQuery.of(context).size.width, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Approuver",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}