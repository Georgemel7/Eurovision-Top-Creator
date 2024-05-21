import 'dart:math';
import 'dart:ui';

import 'package:eurovision_top_creator/alerts/top_creating_dialog.dart';
import 'package:eurovision_top_creator/components/next_button.dart';
import 'package:eurovision_top_creator/constants.dart';
import 'package:eurovision_top_creator/lists.dart';
import 'package:eurovision_top_creator/alerts/save_top_alert.dart';
import 'package:eurovision_top_creator/screens/main_screen.dart';
import 'package:eurovision_top_creator/song_cards_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../components/song_card.dart';
import '../components/song_card_r.dart';
import 'top_song_screen.dart';

bool createButtonWasPressed = false;

class MyTopRearrangeScreen extends StatefulWidget {
  MyTopRearrangeScreen({required this.isCreateButton});

  bool isCreateButton = false;

  void loadNextSongScreen(context) =>
      songsToShow().length == songCards.length && !isCreateButton
          ? showDialog(context: context, builder: (context) => SaveTopAlert())
          : Navigator.popAndPushNamed(context, '/top');
  List<Widget> songsToShow() {
    if (rearrangingSongsToAddList.isNotEmpty || !createButtonWasPressed) {
      return rearrangingSongsToAddList;
    } else {
      List<Widget> songs = <Widget>[];
      List<SongCardR> songsToChangePosition =
          <SongCardR>[] + savedTops.last.savedTop;
      for (int d = 0; d <= savedTops.last.savedTop.length - 1; d++) {
        SongCardR current = songsToChangePosition[d];
        current.position = songsToChangePosition.indexOf(current) + 1;
        songs.add(
          IgnorePointer(
            key: Key('$d'),
            child: current,
          ),
        );
      }
      ;
      return songs;
    }
  }

  void resetRearrangingSongsList() {
    topWasSaved = false;
  }

  @override
  State<MyTopRearrangeScreen> createState() => _MyTopRearrangeScreenState();
}

class _MyTopRearrangeScreenState extends State<MyTopRearrangeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.value(value: context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Eurovision 2024'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              widget.resetRearrangingSongsList();
              currentPageIndex = 1;
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          actions: [
            IconButton(
              onPressed: () {showDialog(context: context, builder: (context) => TopCreatingMenuDialog(context));},
              icon: const Icon(Icons.menu_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 15,
              child: ReorderableListView(
                children: widget.songsToShow(),
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final SongCardR item =
                        rearrangingSongsToAddList.removeAt(oldIndex);
                    rearrangingSongsToAddList.insert(newIndex, item);
                    for (int i = 0; i < rearrangingSongsToAddList.length; i++) {
                      rearrangingSongsToAddList[i].position = i + 1;
                    }
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(kOutlineBorderRadius), color: Colors.grey.shade100),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){showDialog(context: context, builder: (context) => TopCreatingMenuDialog(context));},
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 15, 7, 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kOutlineBorderRadius),
                            color: Colors.red
                          ),
                          child: const Icon(Icons.menu_rounded, color: Colors.white,),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 15, 20, 15),
                        child: DefButton(
                          onPressed: (){widget.loadNextSongScreen(context);},
                          text: 'Next',
                          outlineBorderRadius: true,
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
