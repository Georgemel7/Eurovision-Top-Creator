import 'package:eurovision_top_creator/alerts/save_text_field_alert.dart';
import 'package:eurovision_top_creator/alerts/top_has_already_been_saved_alert.dart';
import 'package:eurovision_top_creator/components/song_card.dart';
import 'package:eurovision_top_creator/components/song_card_r.dart';
import 'package:eurovision_top_creator/lists.dart';
import 'package:eurovision_top_creator/screens/my_top_rearrange_screen.dart';
import 'package:eurovision_top_creator/song_cards_list.dart';
import 'package:flutter/material.dart';

import 'saved_top_alert.dart';
import '../top_save.dart';

bool topWasSaved = false;


class SaveTopAlert extends StatelessWidget {
  SaveTopAlert({super.key,});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('You created your top with all ${songCards.length} songs!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: (){
            if (topWasSaved) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => SavedAlreadyTopAlert());
            } else {
              Navigator.pop(context);
              showDialog(context: context, builder: (context) => SaveTextFieldAlert());
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
