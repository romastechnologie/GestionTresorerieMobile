import 'package:expense_manager/main_page.dart';
import 'package:expense_manager/modules/compte/pages/about_page.dart';
import 'package:expense_manager/modules/history/pages/history_page.dart';
import 'package:expense_manager/modules/compte/pages/contact_page.dart';
import 'package:expense_manager/modules/compte/pages/profil_page.dart';
import 'package:expense_manager/modules/compte/pages/security_page.dart';
import 'package:expense_manager/modules/expenses/pages/category_search_page.dart';
import 'package:expense_manager/modules/history/pages/category_selection_page.dart';
import 'package:expense_manager/modules/login/login_page.dart';
import 'package:expense_manager/modules/notification/notification_page.dart';
import 'package:expense_manager/modules/onboarding/onboarding_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String welcome = '/accueil';
  static const String login = '/login';
  static const String main = '/main';

  static const String categories = '/categories';
  static const String categorieselection = '/categories-selection';
  static const String notifications = '/notifications';
  static const String history = '/history';

  static const String profil = '/profil';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String security = '/security';

  static final List<GetPage> pages = [
    GetPage(name: welcome, page: () => WelcomePage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: main, page: () => MainPage()),
    //Expenses
    GetPage(name: categories, page: () => CategorySearchPage()),
    GetPage(
        name: categorieselection,
        page: () => CategorySelectionPage(initialCategories: [])),
    GetPage(name: notifications, page: () => NotificationPage()),
    GetPage(name: history, page: () => HistoryPage()),
    //Comptes
    GetPage(name: profil, page: () => ProfilPage()),
    GetPage(name: about, page: () => AboutPage()),
    GetPage(name: contact, page: () => ContactPage()),
    GetPage(name: security, page: () => SecurityPage()),
  ];
}
