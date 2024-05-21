import 'package:eurovision_top_creator/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import '../screens/song_screen.dart';

class SongCard extends StatefulWidget {
  SongCard({
    required this.songName,
    required this.singer,
    required this.country,
    required this.videoLink,
    required this.info,
    super.key,
  });
  final String songName;
  final String singer;
  final String country;
  final String videoLink;
  final String info;
  String countryText() {
    List<String> c = country.split(' ');
    if (c.length == 2) {
      String a = c[0];
      String b = c[1];
      return '$a\n$b';
    } else {
      return country;
    }
  }

  late final List<Widget> row = [
    Expanded(
      flex: 2,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Image.asset(
            'assets/singers/${country}-SINGER.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                songName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                singer,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/flags/ESC-HEART-${country}-WHITE.png',
            opacity: const AlwaysStoppedAnimation(.8),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              countryText(),
              style: TextStyle(
                color: Colors.grey.shade200,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SongScreen(
                country: widget.country,
                singer: widget.singer,
                song: widget.songName,
                link: widget.videoLink,
                about: widget.info,
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          gradient: kDefaultGradient,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.row,
        ),
      ),
    );
  }
}
