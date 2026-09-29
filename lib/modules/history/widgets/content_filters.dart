import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContentFilters extends StatefulWidget {
  final Function(Map<String, dynamic>) onFiltersApplied;
  final Map<String, dynamic> initialFilters;

  const ContentFilters({
    super.key,
    required this.onFiltersApplied,
    required this.initialFilters,
  });

  @override
  ContentFiltersState createState() => ContentFiltersState();
}

class ContentFiltersState extends State<ContentFilters> {
  late TextEditingController _searchController;
  late TextEditingController _minAmountController;
  late TextEditingController _maxAmountController;
  DateTimeRange? _dateRange;
  List<String> _selectedCategories = [];
  int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _searchController =
        TextEditingController(text: widget.initialFilters['searchQuery']);
    _minAmountController = TextEditingController(
        text: widget.initialFilters['minAmount'].toString());
    _maxAmountController = TextEditingController(
        text: widget.initialFilters['maxAmount'].toString());
    _dateRange = widget.initialFilters['dateRange'];
    _selectedCategories = List.from(widget.initialFilters['categories'] ?? []);
    _itemsPerPage = widget.initialFilters['itemsPerPage'] ?? 20;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dateRange = picked);
    }
  }

  void _applyFilters() {
    final minAmount = double.tryParse(_minAmountController.text) ?? 0.0;
    final maxAmount = double.tryParse(_maxAmountController.text) ?? 10000.0;

    if (minAmount > maxAmount) {
      Get.snackbar(
        'Erreur',
        'Le montant minimum ne peut pas dépasser le maximum',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    widget.onFiltersApplied({
      'searchQuery': _searchController.text,
      'dateRange': _dateRange,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
      'categories': _selectedCategories,
      'itemsPerPage': _itemsPerPage,
    });
    //Navigator.pop(context);
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _dateRange = null;
      _minAmountController.text = '0';
      _maxAmountController.text = '10000';
      _selectedCategories = [];
      _itemsPerPage = 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Text(
            'Filtres avancés',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              labelText: 'Rechercher',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Période'),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            onPressed: () => _selectDateRange(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_dateRange != null)
                  IconButton(
                    onPressed: () => setState(() => _dateRange = null),
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.redAccent,
                    ),
                  ),
                Text(
                  _dateRange == null
                      ? 'Sélectionner une période'
                      : '${DateFormat('dd/MM/yyyy').format(_dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_dateRange!.end)}',
                ),
                const Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Montant'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    labelText: 'Minimum',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixText: 'FCFA ',
                    suffixStyle: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _maxAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    labelText: 'Maximum',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixText: 'FCFA ',
                    suffixStyle: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Catégories'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final result = await Get.toNamed(
                '/categories-selection',
                arguments: {
                  'initialCategories': _selectedCategories,
                },
              );
              if (result != null && result is List<String>) {
                setState(() => _selectedCategories = result);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Sélectionner des catégories',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          _selectedCategories.isEmpty
              ? const Text(
                  'Aucune catégorie sélectionnée',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedCategories.map((category) {
                    return Chip(
                      backgroundColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      label:
                          Text(category, style: const TextStyle(fontSize: 13)),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () {
                        setState(() => _selectedCategories.remove(category));
                      },
                    );
                  }).toList(),
                ),
          const SizedBox(height: 20),
          _buildSectionTitle('Affichage'),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            dropdownColor: Colors.white,
            initialValue: _itemsPerPage,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            items: [10, 20, 50].map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value éléments par page'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => _itemsPerPage = value!);
            },
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilters,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Réinitialiser',
                      style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: 
                    _applyFilters
                    
        ,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Appliquer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}
