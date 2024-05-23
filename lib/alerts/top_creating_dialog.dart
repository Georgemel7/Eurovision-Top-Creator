import 'package:eurovision_top_creator/alerts/save_text_field_alert.dart';
import 'package:eurovision_top_creator/constants.dart';
import 'package:flutter/material.dart';

import '../components/next_button.dart';

class TopCreatingMenuDialog extends StatelessWidget {
  TopCreatingMenuDialog(this.screenContext);
  final BuildContext screenContext;
  final double buttonHeight = 60;
  final Widget betweenButtonGap = const SizedBox(height: 15);

  final SaveTextFieldAlert saveTextFieldAlert = SaveTextFieldAlert();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Menu'),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        DefButton(
          height: buttonHeight,
          outlineBorderRadius: true,
          color: Colors.red,
          onPressed: () {
            Navigator.pop(context);
            Navigator.popAndPushNamed(screenContext, '/');
          },
          text: 'Cancel top creation',
        ),
        betweenButtonGap,
        DefButton(
          height: buttonHeight,
          outlineBorderRadius: true,
          onPressed: () {
            Navigator.pop(context);
            showDialog(
                context: context, builder: (context) => SaveTextFieldAlert());
          },
          text: 'Save',
        ),
        betweenButtonGap,
        DefButton(
          height: buttonHeight,
          outlineBorderRadius: true,
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Close menu',
        ),
      ],
    );
  }
}
