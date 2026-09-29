import 'package:expense_manager/config/routes.dart';
import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null); // Initialisation pour la locale française

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Définir les délégués de localisation pour supporter le français
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'), // Français
      ],
      locale: const Locale('fr', 'FR'), // Locale par défaut
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.orange,
        useMaterial3: true,
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: AppColors.primary,
          headerForegroundColor: Colors.white,
          dayForegroundColor: WidgetStatePropertyAll(Color.fromRGBO(0, 0, 0, 1)),
          todayBackgroundColor: WidgetStatePropertyAll(AppColors.primary),
          todayForegroundColor: WidgetStatePropertyAll(Colors.white),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.green),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.red),
          ),
      )
      ), 
      initialRoute: AppRoutes.welcome, // Utilisation de la constante de route
      getPages: AppRoutes.pages, // Utilisation des routes définies
    );
  }
}