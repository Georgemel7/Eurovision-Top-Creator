import 'package:eurovision_top_creator/screens/my_top_rearrange_screen.dart';
import 'package:flutter/material.dart';

class SavedTopAlert extends StatelessWidget {
  SavedTopAlert({super.key});
  MyTopRearrangeScreen myTopRearrangeScreen = MyTopRearrangeScreen(isCreateButton: false,);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Your top was saved!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
        TextButton(
          onPressed: () {
            myTopRearrangeScreen.resetRearrangingSongsList();
            Navigator.popAndPushNamed(context, '/');
          },
          child: const Text('Exit'),
        ),
      ],
    );
  }
}
