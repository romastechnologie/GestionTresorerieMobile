import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCarousel extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseCarousel({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    // Filtrer les dépenses du mois en cours
    final now = DateTime.now();
    final currentMonthExpenses = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month);

    // Calcul du montant total par catégorie
    final Map<String, double> totalsByCategory = {};
    for (var e in currentMonthExpenses) {
      totalsByCategory.update(
        e.category,
        (value) => value + e.amount,
        ifAbsent: () => e.amount,
      );
    }

    // Conversion en liste pour l'affichage
    final categoryTotals = totalsByCategory.entries.toList();

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        itemCount: categoryTotals.length,
        itemBuilder: (context, index) {
          final category = categoryTotals[index].key;
          final total = categoryTotals[index].value;

          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "(${categoryTotals.length} dépenses)",
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      NumberFormat.currency(
                        locale: 'fr_FR',
                        symbol: '',
                        decimalDigits: 0,
                      ).format(total),
                      style: TextStyle(
                          fontSize: 17,
                          height: 0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary
                          //AppColors.primary,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    //const SizedBox(height: 8),
                    Text(
                      "F",
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          //AppColors.primary,
                          height: 0),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExpenseCarousel3 extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseCarousel3({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    // Filtrer les dépenses du mois en cours
    final now = DateTime.now();
    final currentMonthExpenses = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month);

    // Calcul du montant total par catégorie
    final Map<String, double> totalsByCategory = {};
    for (var e in currentMonthExpenses) {
      totalsByCategory.update(
        e.category,
        (value) => value + e.amount,
        ifAbsent: () => e.amount,
      );
    }

    // Conversion en liste pour l'affichage
    final categoryTotals = totalsByCategory.entries.toList();

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        itemCount: categoryTotals.length,
        itemBuilder: (context, index) {
          final category = categoryTotals[index].key;
          final total = categoryTotals[index].value;

          return Container(
            width: 100,
            height: 120,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "(${categoryTotals.length} dépenses)",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: NumberFormat.currency(
                          locale: 'fr_FR',
                          symbol: '',
                          decimalDigits: 0,
                        ).format(total),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(
                              2, -7), // vers la droite et vers le haut
                          child: const Text(
                            'Fcfa',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExpenseCarousel2 extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense) onTap;

  const ExpenseCarousel2({
    super.key,
    required this.expenses,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          Color statusColor;
          IconData statusIcon;
          switch (expense.status.toLowerCase()) {
            case 'approuvée':
              statusColor = Colors.green;
              statusIcon = Icons.check;
              break;
            case 'rejetée':
              statusColor = Colors.red;
              statusIcon = Icons.cancel;
              break;
            case 'en attente':
              statusColor = Colors.orange;
              statusIcon = Icons.pending;
              break;
            default:
              statusColor = Colors.grey;
              statusIcon = Icons.pending;
          }
          return GestureDetector(
            onTap: () => onTap(expense),
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Container(
                  //   width: 60,
                  //   height: 60,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primary.withValues(alpha:0.1),
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Icon(
                  //     Icons.monetization_on,
                  //     size: 30,
                  //     color: AppColors.primary,
                  //   ),
                  // ),
                  Container(
                    //color: Colors.red,
                    width: 77,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    margin: EdgeInsets.only(top: 1, right: 1),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          //padding: EdgeInsets.only(left: 10, right: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            statusIcon,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          expense.status,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: statusColor.withValues(alpha: 0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    width: MediaQuery.of(context).size.width,
                    //height: 35,
                    child: Text(
                      expense.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Catégorie : ",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          expense.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          NumberFormat.currency(
                            locale: 'fr_FR',
                            symbol: '',
                            decimalDigits: 0,
                          ).format(expense.amount),
                          style: TextStyle(
                            fontSize: 20,
                            height: 0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        //const SizedBox(height: 8),
                        Text(
                          "Fcfa",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                              height: 0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(expense.date),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
