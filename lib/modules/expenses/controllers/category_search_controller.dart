import 'package:get/get.dart';

class CategorySearchController extends GetxController {
  // Liste complète des catégories
  final _categories = <String>[
    'Alimentation',
    'Transport',
    'Logement',
    'Loisirs',
    'Santé',
    'Éducation',
    'Équipement',
    'Outils',
    'Repas',
    'Autres',
  ].obs;
  List<String> get categories => _categories;

  // Requête de recherche
  final _searchQuery = ''.obs;
  String get searchQuery => _searchQuery.value;
  set searchQuery(String value) => _searchQuery.value = value;

  // Catégories filtrées
  final _filteredCategories = <String>[].obs;
  List<String> get filteredCategories => _filteredCategories;

  // Catégorie sélectionnée (optionnel, pour retourner une sélection)
  final _selectedCategory = ''.obs;
  String get selectedCategory => _selectedCategory.value;
  set selectedCategory(String value) => _selectedCategory.value = value;

  @override
  void onInit() {
    super.onInit();
    // Initialiser les catégories filtrées avec toutes les catégories
    _filteredCategories.assignAll(_categories);
    // Écouter les changements de la requête de recherche
    ever(_searchQuery, (_) => _filterCategories());
  }

  // Filtrer les catégories selon la requête de recherche
  void _filterCategories() {
    if (_searchQuery.value.isEmpty) {
      _filteredCategories.assignAll(_categories);
    } else {
      _filteredCategories.assignAll(
        _categories
            .where((category) => category
                .toLowerCase()
                .contains(_searchQuery.value.toLowerCase()))
            .toList(),
      );
    }
  }

  // Sélectionner une catégorie
  void selectCategory(String category) {
    _selectedCategory.value = category;
    Get.back(result: category); // Retourner la catégorie sélectionnée
  }

  // Réinitialiser la recherche
  void clearSearch() {
    _searchQuery.value = '';
    _filteredCategories.assignAll(_categories);
  }
}