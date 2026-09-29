import 'package:expense_manager/config/colors.dart';
import 'package:expense_manager/modules/expenses/controllers/category_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySearchPage extends StatelessWidget {
  const CategorySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Injecter le contrôleur
    final CategorySearchController controller =
        Get.put(CategorySearchController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Rechercher une catégorie',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => TextField(
                  onChanged: (value) => controller.searchQuery = value,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une catégorie...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: controller.clearSearch,
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                )),
          ),
          // Liste des catégories
          Expanded(
            child: Obx(() => controller.filteredCategories.isEmpty
                ? const Center(
                    child: Text(
                      'Aucune catégorie trouvée',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: 'Inter',
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = controller.filteredCategories[index];
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: 1.0,
                        child: Card(
                          elevation: 1,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.1),
                              child: Text(
                                (category[0]+category[1]).toUpperCase(),
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                            // trailing: const Icon(
                            //   Icons.chevron_right,
                            //   color: Colors.grey,
                            // ),
                            onTap: () => controller.selectCategory(category),
                          ),
                        ),
                      );
                    },
                  )),
          ),
        ],
      ),
    );
  }
}
