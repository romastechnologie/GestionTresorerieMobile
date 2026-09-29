import 'package:expense_manager/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  // Liste complète des dépenses
  final _expenses = <Expense>[].obs;
  List<Expense> get expenses => _expenses;

  // Filtre actuel ("Toutes", "En attente", "Validées", "Rejetées")
  final _currentFilter = "En attente".obs;
  String get currentFilter => _currentFilter.value;
  set currentFilter(String value) => _currentFilter.value = value;

  // Dépenses filtrées
  final _filteredExpenses = <Expense>[].obs;
  List<Expense> get filteredExpenses => _filteredExpenses;

  // Total des dépenses filtrées
  final _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  // Comptage des statuts
  final _statusCounts = {
    "En attente": 0,
    "Approuvée": 0,
    "Rejetée": 0,
  }.obs;
  Map<String, int> get statusCounts => _statusCounts;

  // Filtres avancés (de RightSheetContent)
  final _advancedFilters = <String, dynamic>{
    'searchQuery': '',
    'dateRange': null,
    'minAmount': 0.0,
    'maxAmount': 10000.0,
    'categories': <String>[],
    'itemsPerPage': 20,
  }.obs;
  Map<String, dynamic> get advancedFilters => _advancedFilters;

  @override
  void onInit() {
    super.onInit();
    // Initialiser les dépenses avec les données par défaut
    _expenses.addAll([
      Expense("Repas d'équipe", 180.00, DateTime(2025, 5, 8), "Repas",
          "Déjeuner client avec équipe commerciale", "Rejetée"),
      Expense("Frais de déplacement", 75.30, DateTime(2025, 5, 7), "Transport",
          "Trajet pour réunion à Paris", "Approuvée"),
      Expense("Fournitures de bureau", 42.50, DateTime(2025, 5, 6), "Équipement",
          "Achat de matériel pour le département", "Rejetée"),
      Expense("Hébergement", 320.00, DateTime(2025, 5, 5), "Logement",
          "Nuit d'hôtel pour formation", "Approuvée"),
      Expense("Abonnement logiciel", 99.00, DateTime(2025, 4, 3), "Outils",
          "Renouvellement licence annuelle", "Approuvée"),
      Expense("Déjeuner de projet", 65.00, DateTime(2025, 5, 1), "Repas",
          "Déjeuner avec partenaire", "En attente"),
      Expense("Taxi professionnel", 25.00, DateTime(2025, 4, 30), "Transport",
          "Déplacement chez un client", "Approuvée"),
      Expense("Clé USB sécurisée", 15.99, DateTime(2025, 4, 29), "Équipement",
          "Sauvegarde de fichiers sensibles", "Rejetée"),
      Expense("Location Airbnb", 210.00, DateTime(2025, 4, 28), "Logement",
          "Déplacement longue durée", "En attente"),
      Expense("Outil de gestion", 59.99, DateTime(2025, 4, 27), "Outils",
          "Licence d'un outil de planification", "En attente"),
      Expense("Dîner d’affaires", 120.00, DateTime(2025, 4, 25), "Repas",
          "Dîner avec investisseurs", "Approuvée"),
      Expense("Train pour Lyon", 89.90, DateTime(2025, 4, 22), "Transport",
          "Réunion avec partenaire", "Rejetée"),
      Expense("Scanner portable", 130.00, DateTime(2025, 4, 20), "Équipement",
          "Numérisation de documents", "En attente"),
      Expense("Hébergement conférence", 280.00, DateTime(2025, 4, 18),
          "Logement", "Participation à un congrès", "Approuvée"),
      Expense("Abonnement VPN", 49.90, DateTime(2025, 4, 16), "Outils",
          "Sécurisation de la connexion", "Rejetée"),
      Expense("Petit déjeuner équipe", 45.00, DateTime(2025, 4, 15), "Repas",
          "Motivation d'équipe", "En attente"),
    ]);

    // Appliquer les filtres initiaux
    _applyFilters();

    // Écouter les changements de filtre ou de données
    everAll([_currentFilter, _advancedFilters, _expenses], (_) => _applyFilters());
  }

  // Appliquer les filtres (statut et avancés)
  void _applyFilters() {
    List<Expense> filtered = List.from(_expenses);

    // Appliquer le filtre de statut
    switch (_currentFilter.value) {
      case "En attente":
        filtered = filtered.where((e) => e.status == "En attente").toList();
        break;
      case "Validées":
        filtered = filtered.where((e) => e.status == "Approuvée").toList();
        break;
      case "Rejetées":
        filtered = filtered.where((e) => e.status == "Rejetée").toList();
        break;
      default:
        // "Toutes" n'applique pas de filtre de statut
        break;
    }

    // Appliquer les filtres avancés
    // ignore: invalid_use_of_protected_member
    final filters = _advancedFilters.value;
    final searchQuery = (filters['searchQuery'] as String).toLowerCase();
    final dateRange = filters['dateRange'] as DateTimeRange?;
    final minAmount = filters['minAmount'] as double;
    final maxAmount = filters['maxAmount'] as double;
    final categories = filters['categories'] as List<String>;

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((e) =>
              e.title.toLowerCase().contains(searchQuery) ||
              e.motif.toLowerCase().contains(searchQuery))
          .toList();
    }

    if (dateRange != null) {
      filtered = filtered
          .where((e) =>
              e.date.isAfter(dateRange.start.subtract(const Duration(days: 1))) &&
              e.date.isBefore(dateRange.end.add(const Duration(days: 1))))
          .toList();
    }

    if (minAmount > 0 || maxAmount < 10000) {
      filtered = filtered
          .where((e) => e.amount >= minAmount && e.amount <= maxAmount)
          .toList();
    }

    if (categories.isNotEmpty) {
      filtered = filtered.where((e) => categories.contains(e.category)).toList();
    }

    _filteredExpenses.assignAll(filtered);
    _updateTotalAmount();
    _updateStatusCounts();
  }

  // Mettre à jour le total
  void _updateTotalAmount() {
    _totalAmount.value =
        _filteredExpenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  // Mettre à jour le comptage des statuts
  void _updateStatusCounts() {
    final counts = {
      "En attente": _expenses.where((e) => e.status == "En attente").length,
      "Approuvée": _expenses.where((e) => e.status == "Approuvée").length,
      "Rejetée": _expenses.where((e) => e.status == "Rejetée").length,
    };
    _statusCounts.assignAll(counts);
  }

  // Mettre à jour le statut d'une dépense
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
      _applyFilters(); // Rafraîchir les filtres
    }
  }

  // Appliquer les filtres avancés depuis RightSheetContent
  void applyAdvancedFilters(Map<String, dynamic> filters) {
    _advancedFilters.value = filters;
  }

  // Ajouter une nouvelle dépense
  void addExpense(Expense expense) {
    _expenses.add(expense);
    _applyFilters();
  }
}