import 'dart:math';

import 'package:eurovision_top_creator/constants.dart';
import 'package:eurovision_top_creator/lists.dart';
import 'package:eurovision_top_creator/components/song_card.dart';
import 'package:eurovision_top_creator/screens/my_top_rearrange_screen.dart';
import 'package:eurovision_top_creator/top_save.dart';
import 'package:flutter/material.dart';
import '../components/next_button.dart';
import 'top_song_screen.dart';
import '../song_cards_list.dart';
import 'dart:math';

class MyTopScreen extends StatefulWidget {
  const MyTopScreen({super.key});
  @override
  State<MyTopScreen> createState() => _MyTopScreenState();
}

class _MyTopScreenState extends State<MyTopScreen> {
  Random random = Random();
  late List<TopSave> topsToShow = savedTops + <TopSave>[];

  MyTopRearrangeScreen myTopRearrangeScreen = MyTopRearrangeScreen(
    isCreateButton: true,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'My Tops',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 70,
                child: ListView(
              children: topsToShow,
            )),
            Expanded(
              flex: 11,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(kOutlineBorderRadius),
                ),
                child: DefButton(
                  onPressed: () {
                    myTopRearrangeScreen.loadNextSongScreen(context);
                    rearrangingSongsToAddList.clear();
                    createButtonWasPressed = true;
                  },
                  text: 'Create',
                  outlineBorderRadius: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


