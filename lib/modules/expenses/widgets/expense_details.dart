import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/modules/expenses/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseDetails extends StatelessWidget {
  final Expense expense;

  final bool showActionButtons;

  const ExpenseDetails({
    super.key,
    required this.expense,

    this.showActionButtons = true,
  });


  @override
  Widget build(BuildContext context) {
    Color statusColor;
          switch (expense.status.toLowerCase()) {
            case 'approuvée':
              statusColor = Colors.green;
              break;
            case 'rejetée':
              statusColor = Colors.red;
              break;
            case 'en attente':
              statusColor = Colors.orangeAccent;
              break;
            default:
              statusColor = Colors.grey;
          }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration:  BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(24),
            //   topRight: Radius.circular(24),
            // ),
            color:
            statusColor.withValues(alpha: 0.1)
            //AppColors.primary, 
          ),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: [
                Center(
          child: Container(
            height: 5,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        
                Text(
                  expense.title,
                  style:  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: statusColor,
                    height: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
        //const Divider(thickness: 1, color: Colors.grey, height: 2),
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "• Montant: ${NumberFormat.currency(
                  locale: 'fr_FR',
                  symbol: 'FCFA',
                  decimalDigits: 0,
                ).format(expense.amount)}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "• Catégorie: ${expense.category}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "• Date: ${DateFormat('dd/MM/yyyy').format(expense.date)}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "• Motif de dépense: \n   ${expense.motif}",
                softWrap: true,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
if (expense.status.toLowerCase() == "rejetée")
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "• Motif de rejet:",
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
      ),
      SizedBox(height: 4),
      Text(
        "   ${expense.motif}",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    ],
  ),
if (expense.status.toLowerCase() == "approuvée")
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "• Observations :",
        style: TextStyle(
          fontSize: 16,
color: Colors.green        ),
      ),
      SizedBox(height: 4),
      Text(
        "   ${expense.motif}",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        if (showActionButtons &&
            expense.status.toLowerCase() != "rejetée" &&
            expense.status.toLowerCase() != "approuvée")
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    CustomDialogs.showRejeterDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    minimumSize:
                        Size(0.48 * MediaQuery.of(context).size.width, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.red.shade500,
                  ),
                  child: const Text(
                    "Rejeter",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    CustomDialogs.showApprouverDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    side: const BorderSide(color: Colors.green),
                    minimumSize:
                        Size(0.48 * MediaQuery.of(context).size.width, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "Approuver",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}