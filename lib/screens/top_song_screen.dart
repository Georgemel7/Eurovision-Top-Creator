import 'song_screen.dart';
import 'package:flutter/material.dart';

class TopSongScreen extends SongScreen{
  TopSongScreen({required super.country, required super.singer, required super.song, required super.link, required super.about});
  @override
  bool bottomButtonIsVisible = true;
}
