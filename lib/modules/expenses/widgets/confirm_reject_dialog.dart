import 'package:flutter/material.dart';

class ConfirmRejectDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onConfirm;

  const ConfirmRejectDialog({
    super.key,
    required this.onConfirm,
    this.title = "Confirmer",
    this.content = "Voulez-vous rejeter cette dépense ?",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title, textAlign: TextAlign.center),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Non"),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: const Text(
            "Oui",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}