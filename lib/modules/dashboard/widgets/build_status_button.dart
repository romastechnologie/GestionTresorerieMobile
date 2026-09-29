import 'package:flutter/material.dart';

class BuildStatusButtons extends StatelessWidget {
  final void Function(String) onStatusSelected;
  final EdgeInsets containerPadding;
  final double iconSize;
  final Map<String, int> statusCounts; // Nouveau paramètre pour les comptes

  const BuildStatusButtons({
    super.key,
    required this.onStatusSelected,
    required this.statusCounts, // Ajouté
    this.containerPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: containerPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildButton(
            status: 'En attente',
            text: 'en attente',
            icon: Icons.hourglass_empty,
            color: Colors.orange,
            count: statusCounts['En attente'] ?? 0, // Compte pour ce statut
          ),
          _buildButton(
            status: 'Approuvée',
            text: 'approuvées',
            icon: Icons.check_circle,
            color: Colors.green,
            count: statusCounts['Approuvée'] ?? 0,
          ),
          _buildButton(
              status: 'Rejetée',
              text: 'rejetées',
              icon: Icons.cancel,
              color: Colors.red,
              count: 1000
              //statusCounts['Rejetée'] ?? 0,
              ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String status,
    required String text,
    required IconData icon,
    required Color color,
    required int count, // Nouveau paramètre
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 016),
          ),
          onPressed: () {},
          //() => onStatusSelected(status),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Première ligne: Icône et compteur
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: iconSize, color: Colors.white),
                  const SizedBox(width: 2),
                  Text(
                    count.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 0),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Deuxième ligne: Texte du statut
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
