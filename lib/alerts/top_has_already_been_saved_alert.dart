import 'package:eurovision_top_creator/alerts/save_text_field_alert.dart';
import 'package:eurovision_top_creator/alerts/save_top_alert.dart';
import 'package:flutter/material.dart';

class SavedAlreadyTopAlert extends StatelessWidget {
  SavedAlreadyTopAlert({super.key});
  SaveTextFieldAlert saveTopAlert = SaveTextFieldAlert();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('This top has already been saved!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(context: context, builder: (context) => SaveTextFieldAlert());
          },
          child: const Text('Save anyway'),
        ),
      ],
    );
  }
}
