import 'package:expense_manager/models/expense_model.dart';
import 'package:get/get.dart';

class NotificationPageController extends GetxController {
  // Expenses list (same data as DashboardController for consistency)
  final _expenses = <Expense>[
    // Expense(
    //   "Repas d'équipe",
    //   180.00,
    //   DateTime(2025, 5, 8),
    //   "Repas",
    //   "Déjeuner client avec équipe commerciale",
    //   "En attente",
    // ),
    // Expense(
    //   "Frais de déplacement",
    //   75.30,
    //   DateTime(2025, 5, 7),
    //   "Transport",
    //   "Trajet pour réunion à Paris",
    //   "En attente",
    // ),
    // Expense(
    //   "Fournitures de bureau",
    //   42.50,
    //   DateTime(2025, 5, 6),
    //   "Équipment",
    //   "Achat de matériel pour le département",
    //   "En attente",
    // ),
    // Expense(
    //   "Hébergement",
    //   320.00,
    //   DateTime(2025, 5, 5),
    //   "Logement",
    //   "Nuit d'hôtel pour formation",
    //   "Approuvée",
    // ),
    // Expense(
    //   "Abonnement logiciel",
    //   99.00,
    //   DateTime(2025, 5, 3),
    //   "Outils",
    //   "Renouvellement licence annuelle",
    //   "En attente",
    // ),
  ].obs;

  // Get pending expenses
  List<Expense> get pendingExpenses => _expenses.where((e) => e.status == "En attente").toList();

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
}