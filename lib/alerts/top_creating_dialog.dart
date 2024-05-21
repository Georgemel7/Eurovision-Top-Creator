import 'package:eurovision_top_creator/alerts/save_text_field_alert.dart';
import 'package:eurovision_top_creator/constants.dart';
import 'package:flutter/material.dart';

class TopCreatingMenuDialog extends StatelessWidget {
  TopCreatingMenuDialog(this.screenContext);
  final BuildContext screenContext;
  final MaterialStateProperty<Size> buttonSize =
      MaterialStateProperty.resolveWith<Size>((states) => const Size(300, 60));
  final Widget betweenButtonGap = const SizedBox(height: 15);

  final SaveTextFieldAlert saveTextFieldAlert = SaveTextFieldAlert();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Menu'),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.popAndPushNamed(screenContext, '/');
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) =>
                    const Color.fromRGBO(255, 89, 89, 0.796078431372549)),
            minimumSize: buttonSize,
          ),
          child: const Text('Cancel top creation'),
        ),
        betweenButtonGap,
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(
                context: context, builder: (context) => SaveTextFieldAlert());
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => kThemeColor),
              minimumSize: buttonSize),
          child: const Text('Save'),
        ),
        betweenButtonGap,
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => kThemeColor),
            minimumSize: buttonSize,
          ),
          child: const Text('Close menu'),
        ),
      ],
    );
  }
}
