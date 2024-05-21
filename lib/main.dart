import 'dart:math';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:eurovision_top_creator/components/song_card_r.dart';
import 'package:eurovision_top_creator/screens/my_top_rearrange_screen.dart';
import 'package:eurovision_top_creator/lists.dart';
import 'package:eurovision_top_creator/alerts/save_top_alert.dart';
import 'package:eurovision_top_creator/components/song_card.dart';
import 'package:eurovision_top_creator/top_save.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/main_screen.dart';
import 'screens/my_top_page.dart';
import 'screens/top_song_screen.dart';
import 'song_cards_list.dart';
void loadTopSaves() async {
  var _prefs = await SharedPreferences.getInstance();
  if(_prefs.getInt('top-count')==0){
    return;
  }
  for(int i = 0; i <= (_prefs.getInt('top-count') ?? -1)-1; i++){
    List<SongCardR> songs = <SongCardR>[];
    for(int currentSong = 0; currentSong <= (_prefs.getInt('top-$i-length') ?? 0)-1; currentSong++){
      List<String> currentSongData = _prefs.getStringList('top-$i')![currentSong].split('~');
      SongCardR songCard = SongCardR(songName: currentSongData[0], singer: currentSongData[1], country: currentSongData[2], videoLink: currentSongData[4], info: currentSongData[5]);
      songs.add(songCard);
      songs.last.position = songs.length;
    }
    TopSave currentTop = TopSave(songs, _prefs.getString('top-$i-title') ?? '-1');
    savedTops.add(currentTop);
    print('added');
  }
}
void main() {
  runApp(MyApp());
  loadTopSaves();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  Random random = Random();


  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic){
          return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightDynamic
              //ColorScheme.fromSeed(seedColor: const Color.fromRGBO(
            //   242, 198, 62, 1.0))
          ),
          initialRoute: '/',
          routes: {
            '/':(context) => const MainScreen(),
            '/myTop':(context) => const MyTopScreen(),
            '/top':(context) {
              int _k = 0;
              rearrangingSongsToRemoveList.length <= 1 ? _k = 0 : _k = random.nextInt(rearrangingSongsToRemoveList.length-1);
              final SongCard song = rearrangingSongsToRemoveList[_k];
              rearrangingSongsToRemoveList.removeAt(_k);
              return TopSongScreen(
                country: song.country,
                singer: song.singer,
                song: song.songName,
                link: song.videoLink,
                about: song.info,
              );
            },
            '/rearrange':(context) => MyTopRearrangeScreen(isCreateButton: false,),
          },
        );}
    );

  }
}
