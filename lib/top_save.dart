import 'package:eurovision_top_creator/components/song_card_r.dart';
import 'package:eurovision_top_creator/constants.dart';
import 'package:eurovision_top_creator/screens/saved_top_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopSave extends StatelessWidget {
  TopSave(this.savedTop, this.title);
  List<SongCardR> savedTop;
  final String title;
  void main(){
    savedTop += <SongCardR>[];
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SavedTopViewScreen(list: savedTop, title: title)));},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: kDefaultGradient,
          borderRadius: BorderRadius.circular(kOutlineBorderRadius),
        ),
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Image.asset('assets/flags/ESC-HEART-${savedTop[0].country}-WHITE.png')),
            const SizedBox(width: 20,),
            Expanded(
              flex: 5,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
