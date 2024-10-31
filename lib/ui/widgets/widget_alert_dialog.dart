import 'package:flutter/material.dart';

void showConfirmationAlert({
  required BuildContext context,
  required String title,
  required String subtitle,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          TextButton(
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: const Text("Cancelar", style: TextStyle(color: Colors.black38),),
          ),
          TextButton(
            onPressed: onConfirm,
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
