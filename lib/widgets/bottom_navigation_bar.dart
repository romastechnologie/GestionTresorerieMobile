import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: const BoxDecoration(
        color: Color(0xFF13133A), // Couleur bleu foncé du fond
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _NavIcon(icon: Icons.chat_bubble_outline),
          _NavIcon(icon: Icons.folder_open),
          _NavIcon(icon: Icons.location_on_outlined),
          _NavIcon(icon: Icons.person_outline),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  const _NavIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white,
      size: 28,
    );
  }
}

// import 'package:expense_manager/pages/depenses_en_attente.dart';
// import 'package:flutter/material.dart';

// class MyBottomNavBar extends StatefulWidget {
//   @override
//   _MyBottomNavBarState createState() => _MyBottomNavBarState();
// }

// class _MyBottomNavBarState extends State<MyBottomNavBar> {
//   int _selectedIndex = 0;

//   // Pages à afficher selon l'index sélectionné
//   final List<Widget> _pages = [
//     Center(child: Text('Accueil')),
//     DepensesEnAttente(),
//     Center(child: Text('Profil')),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         backgroundColor: Colors.white,
//         selectedItemColor: Colors.orange, // couleur active
//         unselectedItemColor: Colors.grey,
//         elevation: 8,
//         type: BottomNavigationBarType.fixed, // utile pour >3 éléments

//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Accueil',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.receipt_long),
//             label: 'Dépenses',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }
// }
