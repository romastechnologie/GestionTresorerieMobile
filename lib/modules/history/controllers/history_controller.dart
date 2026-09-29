import 'package:expense_manager/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  // Liste complète des dépenses
  final _expenses = <Expense>[].obs;
  List<Expense> get expenses => _expenses;

  // Catégories
  final _categories = [
    "Toutes",
    "Repas",
    "Transport",
    "Équipement",
    "Logement",
    "Outils",
  ].obs;
  List<String> get categories => _categories;

  // Catégorie sélectionnée
  final _selectedCategory = "Toutes".obs;
  String get selectedCategory => _selectedCategory.value;
  set selectedCategory(String value) => _selectedCategory.value = value;

  // Périodes temporelles
  final _timeFilters = [
    "Aujourd'hui",
    "Hier",
    "7 jours",
    "30 jours",
    "Ce mois",
    "Mois dernier",
    "Cette année",
  ].obs;
  List<String> get timeFilters => _timeFilters;

  // Période sélectionnée
  final _selectedTimeFilter = "30 jours".obs;
  String get selectedTimeFilter => _selectedTimeFilter.value;
  set selectedTimeFilter(String value) => _selectedTimeFilter.value = value;

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

  // Index de l'onglet actif
  final _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;
  set tabIndex(int value) => _tabIndex.value = value;

  // Filtres avancés
  final _advancedFilters = <String, dynamic>{
    'searchQuery': '',
    'dateRange': null,
    'minAmount': 0.0,
    'maxAmount': 10000.0,
    'categories': <String>[],
    'itemsPerPage': 20,
  }.obs;
  Map<String, dynamic> get advancedFilters => _advancedFilters;

  // Pagination
  final _currentPage = 1.obs;
  int get currentPage => _currentPage.value;
  set currentPage(int value) => _currentPage.value = value;

  int get totalPages {
    final itemsPerPage = _advancedFilters['itemsPerPage'] as int;
    return (_allFilteredExpenses.length / itemsPerPage).ceil();
  }

  // Liste temporaire pour stocker toutes les dépenses filtrées avant pagination
  final _allFilteredExpenses = <Expense>[].obs;
  List<Expense> get allFilteredExpenses => _allFilteredExpenses;

  @override
  void onInit() {
    super.onInit();
    // Initialiser les dépenses avec 75 entrées
    _expenses.addAll([
      // Catégorie: Repas (15 dépenses)
      Expense("Repas d'équipe", 180.00, DateTime(2025, 5, 8), "Repas",
          "Déjeuner client avec équipe commerciale", "Rejetée"),
      Expense("Dîner professionnel", 120.50, DateTime(2025, 5, 15), "Repas",
          "Dîner avec partenaires", "Approuvée"),
      Expense("Petit-déjeuner réunion", 45.00, DateTime(2025, 5, 14), "Repas",
          "Petit-déj pour réunion matinale", "En attente"),
      Expense("Repas client", 200.00, DateTime(2025, 5, 13), "Repas",
          "Déjeuner avec client important", "Approuvée"),
      Expense("Pause café", 25.30, DateTime(2025, 5, 12), "Repas",
          "Café pour équipe projet", "Approuvée"),
      Expense("Repas formation", 80.00, DateTime(2025, 5, 11), "Repas",
          "Déjeuner lors de la formation", "Rejetée"),
      Expense("Dîner séminaire", 150.75, DateTime(2025, 5, 10), "Repas",
          "Dîner après séminaire", "Approuvée"),
      Expense("Repas équipe projet", 90.00, DateTime(2025, 5, 9), "Repas",
          "Déjeuner pour équipe technique", "En attente"),
      Expense("Collation réunion", 35.20, DateTime(2025, 5, 7), "Repas",
          "Snacks pour réunion", "Approuvée"),
      Expense("Repas voyage d'affaires", 110.00, DateTime(2025, 5, 6), "Repas",
          "Dîner lors de déplacement", "Approuvée"),
      Expense("Déjeuner sponsorisé", 60.00, DateTime(2025, 5, 5), "Repas",
          "Déjeuner avec sponsor", "Rejetée"),
      Expense("Repas entretien", 70.50, DateTime(2025, 5, 4), "Repas",
          "Déjeuner avec candidat", "Approuvée"),
      Expense("Café client", 20.00, DateTime(2025, 5, 3), "Repas",
          "Café lors de rendez-vous", "En attente"),
      Expense("Repas networking", 130.00, DateTime(2025, 5, 2), "Repas",
          "Dîner événement networking", "Approuvée"),
      Expense("Déjeuner équipe", 95.00, DateTime(2025, 5, 1), "Repas",
          "Déjeuner pour cohésion d'équipe", "Approuvée"),
      // Catégorie: Transport (15 dépenses)
      Expense("Frais de déplacement", 75.30, DateTime(2025, 5, 7), "Transport",
          "Trajet pour réunion à Paris", "Approuvée"),
      Expense("Billet de train", 120.00, DateTime(2025, 5, 16), "Transport",
          "Train pour conférence", "Approuvée"),
      Expense("Taxi réunion", 30.50, DateTime(2025, 5, 15), "Transport",
          "Taxi pour réunion client", "En attente"),
      Expense("Vol interne", 250.00, DateTime(2025, 5, 14), "Transport",
          "Vol pour réunion régionale", "Approuvée"),
      Expense("Location voiture", 80.00, DateTime(2025, 5, 13), "Transport",
          "Voiture pour déplacement", "Rejetée"),
      Expense("Bus formation", 15.00, DateTime(2025, 5, 12), "Transport",
          "Bus pour centre de formation", "Approuvée"),
      Expense("Péage autoroute", 10.20, DateTime(2025, 5, 11), "Transport",
          "Péage pour voyage d'affaires", "Approuvée"),
      Expense("Métro client", 5.00, DateTime(2025, 5, 10), "Transport",
          "Ticket métro pour rendez-vous", "En attente"),
      Expense("Billet avion", 300.00, DateTime(2025, 5, 9), "Transport",
          "Vol pour salon professionnel", "Approuvée"),
      Expense("Taxi aéroport", 45.00, DateTime(2025, 5, 8), "Transport",
          "Taxi vers aéroport", "Approuvée"),
      Expense("Train séminaire", 90.00, DateTime(2025, 5, 6), "Transport",
          "Train pour séminaire", "Rejetée"),
      Expense("Frais kilométriques", 60.00, DateTime(2025, 5, 5), "Transport",
          "Déplacement en voiture personnelle", "Approuvée"),
      Expense("Vélo partagé", 3.50, DateTime(2025, 5, 4), "Transport",
          "Location vélo pour réunion", "Approuvée"),
      Expense("Bus conférence", 12.00, DateTime(2025, 5, 3), "Transport",
          "Bus pour conférence", "En attente"),
      Expense("Parking réunion", 20.00, DateTime(2025, 5, 2), "Transport",
          "Parking lors de réunion", "Approuvée"),
      // Catégorie: Équipement (15 dépenses)
      Expense("Fournitures de bureau", 42.50, DateTime(2025, 5, 6),
          "Équipement", "Achat de matériel pour le département", "Rejetée"),
      Expense("Ordinateur portable", 450.00, DateTime(2025, 5, 15),
          "Équipement", "PC pour nouvel employé", "Approuvée"),
      Expense("Imprimante", 200.00, DateTime(2025, 5, 14), "Équipement",
          "Imprimante pour bureau", "Approuvée"),
      Expense("Papeterie", 25.00, DateTime(2025, 5, 13), "Équipement",
          "Fournitures pour réunion", "En attente"),
      Expense("Écran externe", 150.00, DateTime(2025, 5, 12), "Équipement",
          "Moniteur pour développeur", "Approuvée"),
      Expense("Clavier ergonomique", 60.00, DateTime(2025, 5, 11), "Équipement",
          "Clavier pour employé", "Rejetée"),
      Expense("Souris sans fil", 30.00, DateTime(2025, 5, 10), "Équipement",
          "Souris pour équipe", "Approuvée"),
      Expense("Casque audio", 80.00, DateTime(2025, 5, 9), "Équipement",
          "Casque pour appels", "Approuvée"),
      Expense("Tableau blanc", 100.00, DateTime(2025, 5, 8), "Équipement",
          "Tableau pour salle de réunion", "En attente"),
      Expense("Projecteur", 300.00, DateTime(2025, 5, 7), "Équipement",
          "Projecteur pour présentations", "Approuvée"),
      Expense("Cartouches encre", 50.00, DateTime(2025, 5, 5), "Équipement",
          "Encre pour imprimante", "Approuvée"),
      Expense("Disque dur externe", 120.00, DateTime(2025, 5, 4), "Équipement",
          "Stockage pour équipe", "Rejetée"),
      Expense("Câbles HDMI", 15.00, DateTime(2025, 5, 3), "Équipement",
          "Câbles pour salle de conf", "Approuvée"),
      Expense("Chaises bureau", 200.00, DateTime(2025, 5, 2), "Équipement",
          "Chaises pour nouveau bureau", "Approuvée"),
      Expense("Lampes bureau", 40.00, DateTime(2025, 5, 1), "Équipement",
          "Lampes pour employés", "En attente"),
      // Catégorie: Logement (15 dépenses)
      Expense("Hébergement", 320.00, DateTime(2025, 5, 5), "Logement",
          "Nuit d'hôtel pour formation", "Approuvée"),
      Expense("Hôtel conférence", 250.00, DateTime(2025, 5, 16), "Logement",
          "Hôtel pour conférence", "Approuvée"),
      Expense("Airbnb réunion", 150.00, DateTime(2025, 5, 15), "Logement",
          "Logement pour réunion régionale", "En attente"),
      Expense("Hôtel séminaire", 200.00, DateTime(2025, 5, 14), "Logement",
          "Hôtel pour séminaire", "Approuvée"),
      Expense("Auberge formation", 100.00, DateTime(2025, 5, 13), "Logement",
          "Auberge pour formation", "Rejetée"),
      Expense("Hôtel voyage", 280.00, DateTime(2025, 5, 12), "Logement",
          "Hôtel pour voyage d'affaires", "Approuvée"),
      Expense("Location appartement", 350.00, DateTime(2025, 5, 11), "Logement",
          "Appartement pour mission", "Approuvée"),
      Expense("Hôtel client", 180.00, DateTime(2025, 5, 10), "Logement",
          "Hôtel pour visite client", "En attente"),
      Expense("Chambre conférence", 220.00, DateTime(2025, 5, 9), "Logement",
          "Chambre pour conférence", "Approuvée"),
      Expense("Hébergement équipe", 300.00, DateTime(2025, 5, 8), "Logement",
          "Hôtel pour équipe projet", "Approuvée"),
      Expense("Hôtel formation", 160.00, DateTime(2025, 5, 7), "Logement",
          "Hôtel pour formation interne", "Rejetée"),
      Expense("Airbnb séminaire", 140.00, DateTime(2025, 5, 6), "Logement",
          "Logement pour séminaire", "Approuvée"),
      Expense("Hôtel réunion", 190.00, DateTime(2025, 5, 4), "Logement",
          "Hôtel pour réunion client", "Approuvée"),
      Expense("Chambre voyage", 170.00, DateTime(2025, 5, 3), "Logement",
          "Chambre pour déplacement", "En attente"),
      Expense("Hôtel salon", 260.00, DateTime(2025, 5, 2), "Logement",
          "Hôtel pour salon professionnel", "Approuvée"),
      // Catégorie: Outils (15 dépenses)
      Expense("Abonnement logiciel", 99.00, DateTime(2025, 4, 3), "Outils",
          "Renouvellement licence annuelle", "Approuvée"),
      Expense("Licence logiciel", 150.00, DateTime(2025, 5, 16), "Outils",
          "Abonnement logiciel design", "Approuvée"),
      Expense("Cloud storage", 50.00, DateTime(2025, 5, 15), "Outils",
          "Stockage cloud pour équipe", "En attente"),
      Expense("Outil CRM", 200.00, DateTime(2025, 5, 14), "Outils",
          "Abonnement CRM annuel", "Approuvée"),
      Expense("Logiciel comptabilité", 80.00, DateTime(2025, 5, 13), "Outils",
          "Logiciel pour finances", "Rejetée"),
      Expense("Abonnement projet", 120.00, DateTime(2025, 5, 12), "Outils",
          "Outil de gestion de projet", "Approuvée"),
      Expense("Licence sécurité", 60.00, DateTime(2025, 5, 11), "Outils",
          "Antivirus pour équipe", "Approuvée"),
      Expense("Outil collaboration", 90.00, DateTime(2025, 5, 10), "Outils",
          "Plateforme collaborative", "En attente"),
      Expense("Logiciel analyse", 110.00, DateTime(2025, 5, 9), "Outils",
          "Outil d'analyse de données", "Approuvée"),
      Expense("Abonnement cloud", 70.00, DateTime(2025, 5, 8), "Outils",
          "Service cloud pour backups", "Approuvée"),
      Expense("Outil marketing", 130.00, DateTime(2025, 5, 7), "Outils",
          "Plateforme marketing", "Rejetée"),
      Expense("Licence développeur", 100.00, DateTime(2025, 5, 6), "Outils",
          "Outil pour développeurs", "Approuvée"),
      Expense("Abonnement API", 40.00, DateTime(2025, 5, 5), "Outils",
          "Accès à API externe", "Approuvée"),
      Expense("Outil design", 85.00, DateTime(2025, 5, 4), "Outils",
          "Logiciel de design graphique", "En attente"),
      Expense("Licence formation", 75.00, DateTime(2025, 5, 3), "Outils",
          "Plateforme e-learning", "Approuvée"),
    ]);

    // Appliquer les filtres initiaux
    _applyFilters();

    // Écouter les changements de filtres, onglets, données ou page
    everAll([
      _selectedCategory,
      _selectedTimeFilter,
      _tabIndex,
      _expenses,
      _advancedFilters,
      _currentPage,
    ], (_){
  _applyFilters();
  _updateTotalAmount(); // Deuxième fonction
});
  }

  // Appliquer les filtres (catégorie, période, onglet, filtres avancés, pagination)
  void _applyFilters() {
    List<Expense> filtered = List.from(_expenses);

    // Filtrer par catégorie
    if (_selectedCategory.value != "Toutes") {
      filtered =
          filtered.where((e) => e.category == _selectedCategory.value).toList();
    }

    // Filtrer par période temporelle
    final now = DateTime.now();
    switch (_selectedTimeFilter.value) {
      case "Aujourd'hui":
        filtered = filtered
            .where((e) =>
                e.date.day == now.day &&
                e.date.month == now.month &&
                e.date.year == now.year)
            .toList();
        break;
      case "Hier":
        final yesterday = now.subtract(const Duration(days: 1));
        filtered = filtered
            .where((e) =>
                e.date.day == yesterday.day &&
                e.date.month == yesterday.month &&
                e.date.year == yesterday.year)
            .toList();
        break;
      case "7 jours":
        final sevenDaysAgo = now.subtract(const Duration(days: 7));
        filtered = filtered
            .where((e) =>
                e.date.isAfter(sevenDaysAgo) ||
                e.date.isAtSameMomentAs(sevenDaysAgo))
            .toList();
        break;
      case "30 jours":
        final thirtyDaysAgo = now.subtract(const Duration(days: 30));
        filtered = filtered
            .where((e) =>
                e.date.isAfter(thirtyDaysAgo) ||
                e.date.isAtSameMomentAs(thirtyDaysAgo))
            .toList();
        break;
      case "Ce mois":
        filtered = filtered
            .where((e) => e.date.month == now.month && e.date.year == now.year)
            .toList();
        break;
      case "Mois dernier":
        final lastMonth = DateTime(now.year, now.month - 1, 1);
        filtered = filtered
            .where((e) =>
                e.date.month == lastMonth.month &&
                e.date.year == lastMonth.year)
            .toList();
        break;
      case "Cette année":
        filtered = filtered.where((e) => e.date.year == now.year).toList();
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
              e.date
                  .isAfter(dateRange.start.subtract(const Duration(days: 1))) &&
              e.date.isBefore(dateRange.end.add(const Duration(days: 1))))
          .toList();
    }

    if (minAmount > 0 || maxAmount < 10000) {
      filtered = filtered
          .where((e) => e.amount >= minAmount && e.amount <= maxAmount)
          .toList();
    }

    if (categories.isNotEmpty) {
      filtered =
          filtered.where((e) => categories.contains(e.category)).toList();
    }

    // Filtrer par onglet (Toutes, Validées, Rejetées)
    // switch (_tabIndex.value) {
    //   case 1: // Validées
    //     filtered = filtered.where((e) => e.status == "Approuvée").toList();
    //     break;
    //   case 2: // Rejetées
    //     filtered = filtered.where((e) => e.status == "Rejetée").toList();
    //     break;
    //   default: // Toutes
    //     break;
    // }

    // Stocker toutes les dépenses filtrées avant pagination
    _allFilteredExpenses.assignAll(filtered);

    // Appliquer la pagination
    final itemsPerPage = filters['itemsPerPage'] as int;
    final startIndex = (_currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    filtered = filtered
        .asMap()
        .entries
        .where((entry) => entry.key >= startIndex && entry.key < endIndex)
        .map((entry) => entry.value)
        .toList();

    _filteredExpenses.assignAll(filtered);
    _updateTotalAmount();
    _updateStatusCounts();

    // Réinitialiser à la première page si la page actuelle est invalide
    if (_currentPage.value > totalPages && totalPages > 0) {
      _currentPage.value = totalPages;
      _applyFilters();
    }
  }

  // Mettre à jour le total
 void _updateTotalAmount() {
    List<Expense> filtered = List.from(_filteredExpenses);

    switch (_tabIndex.value) {
      case 1: // Validées
        filtered = filtered.where((e) => e.status == "Approuvée").toList();
        break;
      case 2: // Rejetées
        filtered = filtered.where((e) => e.status == "Rejetée").toList();
        break;
      default: // Toutes
        break;
    }

    // Calculer le total sur la liste filtrée
    _totalAmount.value = filtered.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  // Mettre à jour le comptage des statuts
  void _updateStatusCounts() {
    final counts = {
      "En attente":
          _filteredExpenses.where((e) => e.status == "En attente").length,
      "Approuvée":
          _filteredExpenses.where((e) => e.status == "Approuvée").length,
      "Rejetée": _filteredExpenses.where((e) => e.status == "Rejetée").length,
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

  // Ajouter une nouvelle dépense
  void addExpense(Expense expense) {
    _expenses.add(expense);
    _applyFilters();
  }

  // Réinitialiser les filtres
  void resetFilters() {
    _selectedCategory.value = "Toutes";
    _selectedTimeFilter.value = "30 jours";
    _tabIndex.value = 0;
    _currentPage.value = 1; // Réinitialiser à la première page
    _advancedFilters.value = {
      'searchQuery': '',
      'dateRange': null,
      'minAmount': 0.0,
      'maxAmount': 10000.0,
      'categories': <String>[],
      'itemsPerPage': 20,
    };
  }

  // Appliquer les filtres avancés
  void applyAdvancedFilters(Map<String, dynamic> filters) {
    _currentPage.value =
        1; // Revenir à la première page lors de l'application des filtres
    _advancedFilters.value = filters;
  }

  // Navigation de pagination
  void nextPage() {
    if (_currentPage.value < totalPages) {
      _currentPage.value++;
    }
  }

  void previousPage() {
    if (_currentPage.value > 1) {
      _currentPage.value--;
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      _currentPage.value = page;
    }
  }
}
