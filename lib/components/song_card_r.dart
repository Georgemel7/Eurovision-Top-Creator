import 'package:eurovision_top_creator/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'song_card.dart';

class SongCardR extends SongCard {
  SongCardR(
      {super.key,
      required super.songName,
      required super.singer,
      required super.country,
      required super.videoLink,
      required super.info,});
  late int position = rearrangingSongsToAddList.indexOf(this) + 1;
  @override
  late List<Widget> row = <Widget>[
        Expanded(
          flex:1,
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            padding: const EdgeInsets.all(2),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '$position',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ] +
      super.row +
      <Widget>[
        const Expanded(
          flex: 1,
          child: Icon(
            Icons.drag_handle_rounded,
            color: Colors.white,
          ),
        ),
      ];
}
