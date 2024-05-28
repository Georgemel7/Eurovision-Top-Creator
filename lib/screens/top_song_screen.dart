import 'package:flutter/cupertino.dart';

import '../components/next_button.dart';
import '../components/song_card_r.dart';
import '../lists.dart';
import 'song_screen.dart';
import 'package:flutter/material.dart';

class TopSongScreen extends SongScreen{
  TopSongScreen({required super.country, required super.singer, required super.song, required super.link, required super.about});
  @override
  List<Widget> columnWidgetList(BuildContext context, Function onSelectionChanged){
    List<Widget> list = super.columnWidgetList(context, onSelectionChanged) + <Widget>[Expanded(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: DefButton(
            tonal: true,
            onPressed: () {
              if (!nextButtonWasPressed) {
                rearrangingSongsToAddList.add(
                  SongCardR(
                    songName: song,
                    singer: singer,
                    country: country,
                    videoLink: link,
                    info: about,
                    key: Key('$counter'),
                  ),
                );
              }
              nextButtonWasPressed = true;
              counter++;
              Navigator.popAndPushNamed(context, '/rearrange');
            },
            text: 'Next',
            outlineBorderRadius: true,
          )
      ),
    )];
    return list;
  }
}
