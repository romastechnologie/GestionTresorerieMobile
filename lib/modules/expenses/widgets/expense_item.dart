// import 'package:expense_manager/models/expense_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ExpenseItem extends StatelessWidget {
//   final Expense expense;
//   final Function(Expense) onTap;

//   const ExpenseItem({super.key, required this.expense, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     Color statusColor;
//     IconData statusIcon;
//     switch (expense.status.toLowerCase()) {
//       case 'approuvée':
//         statusColor = Colors.green;
//         statusIcon = Icons.check;
//         break;
//       case 'rejetée':
//         statusColor = Colors.red;
//         statusIcon = Icons.cancel;
//         break;
//       case 'en attente':
//         statusColor = Colors.orange;
//         statusIcon = Icons.pending;
//         break;
//       default:
//         statusColor = Colors.grey;
//         statusIcon = Icons.pending;
//     }

//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () => onTap(expense),
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       expense.title,
//                       style:
//                           TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
//                     ),
//                     Text(
//                       "${DateFormat('dd/MM/yyyy').format(expense.date)} - ${expense.category}",
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           NumberFormat.currency(
//                             locale: 'fr_FR',
//                             symbol: 'FCFA',
//                             decimalDigits: 0,
//                           ).format(expense.amount),
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.2,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(1),
//                         decoration: BoxDecoration(
//                           color: statusColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           statusIcon,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         expense.status,
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           color: statusColor,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           color: Colors.grey[100],
//           height: 5,
//         ),
//       ],
//     );
//   }
// }

import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final Function(Expense) onTap;

  const ExpenseItem({super.key, required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Notification badge
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Expense details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Catégorie : ${expense.category}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
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
                ],
              ),
            ),
            // Status label
            Column(
              
              children: [
                const SizedBox(height: 24,),
                Text(
                    DateFormat('dd/MM/yyyy').format(expense.date),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    expense.status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
