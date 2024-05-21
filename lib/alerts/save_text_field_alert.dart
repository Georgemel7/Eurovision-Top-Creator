import 'package:eurovision_top_creator/alerts/save_top_alert.dart';
import 'package:eurovision_top_creator/alerts/saved_top_alert.dart';
import 'package:eurovision_top_creator/alerts/top_has_already_been_saved_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/song_card.dart';
import '../components/song_card_r.dart';
import '../lists.dart';
import '../screens/my_top_rearrange_screen.dart';
import '../top_save.dart';

class SaveTextFieldAlert extends StatelessWidget {
   TextEditingController controller = TextEditingController();
String textValue = '';
   MyTopRearrangeScreen myTopRearrangeScreen = MyTopRearrangeScreen(isCreateButton: false,);
   void saveTop(context) async {
     var prefs = await SharedPreferences.getInstance();
     createButtonWasPressed = true;
     if(topWasSaved){
       List<SongCardR> _songs = <SongCardR>[] + savedTops.last.savedTop;
       savedTops.add(TopSave(_songs, textValue));
     } else {
       savedTops.add(TopSave(rearrangingSongsToAddList, textValue));
       savedTops[savedTops.length -1].main();
       for (int i = 0; i <= rearrangingSongsToAddList.length - 1; i++) {
         SongCardR currentSongItem = rearrangingSongsToAddList[i];
         rearrangingSongsToRemoveList.add(SongCard(
             songName: currentSongItem.songName,
             singer: currentSongItem.singer,
             country: currentSongItem.country,
             videoLink: currentSongItem.videoLink,
             info: currentSongItem.info));
       }
       rearrangingSongsToAddList.clear();
     }
     List<String> topToSave = [];
     for(int h = 0; h <= savedTops.last.savedTop.length-1; h++){
       SongCardR _currentSong = savedTops.last.savedTop[h];
       String songData = '${_currentSong.songName}~${_currentSong.singer}~${_currentSong.country}~${_currentSong.position}~${_currentSong.videoLink}~${_currentSong.info}';
       topToSave.add(songData);
     }
     await prefs.setStringList('top-${savedTops.length-1}', topToSave);
     await prefs.setString('top-${savedTops.length-1}-title', savedTops.last.title);
     await prefs.setInt('top-${savedTops.length-1}-length', savedTops.length);
     await prefs.setInt('top-count', savedTops.length);
     topWasSaved = true;
     Navigator.popAndPushNamed(context, '/rearrange');
     showDialog(
         context: context,
         builder: (context) => SavedTopAlert());
   }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter title'),
      content: TextField(
        controller: controller,
        onSubmitted: (String value){
          textValue = controller.text;
          saveTop(context);
        },
      ),
      actions: [
        TextButton(
          onPressed: (){Navigator.pop(context);},
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
