import 'package:flutter/material.dart';

class ExpenseFilters {
  static List<String> categories = [
    "Toutes",
    "Repas",
    "Transport",
    "Équipement",
    "Logement",
    "Outils",
  ];

  static List<String> timeFilters = ["Aujourd'hui", "7 jours", "30 jours"];

  static Widget buildCategoryFilter({
    required BuildContext context,
    required String selectedCategory,
    required ValueChanged<String?> onChanged,
  }) {
    return _buildFilterDropdown(
      context: context,
      value: selectedCategory,
      items: categories,
      onChanged: onChanged,
    );
  }

  static Widget buildTimeFilter({
    required BuildContext context,
    required String selectedTimeFilter,
    required ValueChanged<String?> onChanged,
  }) {
    return _buildFilterDropdown(
      context: context,
      value: selectedTimeFilter,
      items: timeFilters,
      onChanged: onChanged,
    );
  }

  static Widget _buildFilterDropdown({
    required BuildContext context,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 0.4 * MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue), // Adaptez à votre couleur
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  
}