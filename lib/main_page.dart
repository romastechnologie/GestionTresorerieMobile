import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:expense_manager/modules/dashboard/dashboard_page.dart';
import 'package:expense_manager/modules/compte/pages/compte_page.dart';
import 'package:expense_manager/modules/expenses/pages/add_expense_page.dart';
import 'package:expense_manager/modules/expenses/pages/expenses_page.dart';
import 'package:expense_manager/config/colors.dart';
import 'package:expense_manager/modules/history/pages/history_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  bool _isAddExpensePage = false; // Indique si AddExpensePage est affichée

  final List<Widget> _pages = [
    DashboardPage(),
    ExpensesPage(),
    HistoryPage(),
    ComptePage(),
  ];

  // Listes des icônes actives (pleines) et inactives (outlined)
  final List<IconData> _activeIcons = [
    Icons.home,
    Icons.payments,
    Icons.timelapse,
    Icons.person,
  ];

  final List<IconData> _inactiveIcons = [
    Icons.home_outlined,
    Icons.payments_outlined,
    Icons.timelapse_outlined,
    Icons.person_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // Afficher AddExpensePage si _isAddExpensePage est vrai, sinon la page courante
      body: _isAddExpensePage ? AddExpensePage(
        onBack: () {
          setState(() {
            _isAddExpensePage = false; // Revenir à la page précédente
          });
        },
      ) : _pages[_currentIndex],
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: ClipOval(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isAddExpensePage = true; // Afficher AddExpensePage
              });
            },
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text("Ajouter", style: TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _activeIcons.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppColors.primary : Colors.grey[400];
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(
                    isActive ? _activeIcons[index] : _inactiveIcons[index],
                    size: 28,
                    color: color,
                  ),
                  Text(
                    ['Accueil', 'Dépenses', 'Historique', 'Compte'][index],
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          );
        },
        backgroundColor: Colors.white,
        splashColor: AppColors.primary,
        elevation: 8,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        height: MediaQuery.of(context).size.height * 1.2 / 12,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _isAddExpensePage = false; // Réinitialiser si on change de page
        }),
      ),
    );
  }
}