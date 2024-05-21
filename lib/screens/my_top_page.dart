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
      padding: const EdgeInsets.all(20),
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
              flex: 7,
                child: ListView(
              children: topsToShow,
            )),
            Expanded(
              flex: 1,
              child: DefButton(
                onPressed: () {
                  myTopRearrangeScreen.loadNextSongScreen(context);
                  rearrangingSongsToAddList.clear();
                  createButtonWasPressed = true;
                },
                text: 'Create',
                outlineBorderRadius: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


