import 'package:expense_manager/models/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPageController extends GetxController {
  // Expenses list
  final _expenses = <Expense>[
    Expense(
      "Repas d'équipe",
      1800000000.00,
      DateTime(2025, 5, 8),
      "Repas",
      "Déjeuner c0lient avec équipe commerciale",
      "En attente",
    ),
    Expense(
      "Frais de déplacement",
      75.30,
      DateTime(2025, 5, 7),
      "Transport",
      "Trajet pour réunion à Paris",
      "Approuvée",
    ),
    Expense(
      "Fournitures de bureau",
      42.50,
      DateTime(2025, 5, 6),
      "Équipment",
      "Achat de matériel pour le département",
      "Rejetée",
    ),
    Expense(
      "Hébergement",
      320.00,
      DateTime(2025, 5, 5),
      "Logement",
      "Nuit d'hôtel pour formation",
      "Approuvée",
    ),
    Expense(
      "Abonnement logiciel",
      99.00,
      DateTime(2025, 5, 3),
      "Outils",
      "Renouvellement licence annuelle",
      "En attente",
    ),
  ].obs;
  //get expenses list for the carroussel

  // Visibility toggle for amount
  final isAmountVisible = true.obs;

  // Selected status for filtering
  final selectedStatus = 'Tous'.obs;

  List<Expense> get expenses {
    return _expenses.toList();
  }

  // Get filtered expenses based on selected status
    List<Expense> get pendingExpenses => _expenses.where((e) => e.status == "En attente").toList();


  // Calculate total amount
  double get totalAmount =>
      expenses.fold(0.0, (sum, expense) => sum + expense.amount);

  // Count statuses
  Map<String, int> getStatusCounts() {
    final counts = {"En attente": 0, "Approuvée": 0, "Rejetée": 0};
    for (var expense in expenses) {
      counts[expense.status] = (counts[expense.status] ?? 0) + 1;
    }
    return counts;
  }

  // Get category data for pie chart
  List<PieChartSectionData> getCategoryData() {
    final categoryTotals = <String, double>{};
    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    return categoryTotals.entries.map((entry) {
      final percentage =
          totalAmount > 0 ? (entry.value / totalAmount) * 100 : 0;
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: percentage > 0 ? '${percentage.toStringAsFixed(1)}%' : '',
        radius: 80,
        titleStyle: TextStyle(fontSize: 12, color: Colors.white),
      );
    }).toList();
  }

  // Get category color
  Color _getCategoryColor(String category) {
    switch (category) {
      case "Repas":
        return Colors.orange;
      case "Transport":
        return Colors.blue;
      case "Équipment":
        return Colors.teal;
      case "Logement":
        return Colors.green;
      case "Outils":
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  // Toggle amount visibility
  void toggleAmountVisibility() {
    isAmountVisible.toggle();
  }

  // Update expense status
  void updateExpenseStatus(Expense expense, String newStatus) {
    final index = _expenses.indexOf(expense);
    if (index != -1) {
      _expenses[index] = Expense(
        expense.title,
        expense.amount,
        expense.date,
        expense.category,
        expense.motif,
        newStatus,
      );
      update();
    }
  }

  // Update selected status for filtering
  void updateSelectedStatus(String status) {
    selectedStatus.value = status;
    update();
  }
}
