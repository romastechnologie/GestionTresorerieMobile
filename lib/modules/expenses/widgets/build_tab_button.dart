import 'package:flutter/material.dart';
import '../../../config/colors.dart';

class BuildTabButton extends StatelessWidget {
  final String label;
  final String count;
  final bool isSelected;
  final VoidCallback onPressed;

  const BuildTabButton({
    super.key,
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.white24,
        foregroundColor: isSelected ? AppColors.primary : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      onPressed: onPressed,
      child: Text(
        "$label ${label.toLowerCase() == "toutes" ? '' : '($count)'}",
        style: TextStyle(fontSize: 11),
      ),
    );
  }
}
