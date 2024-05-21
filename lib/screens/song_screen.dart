import 'package:eurovision_top_creator/components/next_button.dart';
import 'package:eurovision_top_creator/lists.dart';
import 'package:eurovision_top_creator/components/song_card_r.dart';
import 'package:eurovision_top_creator/song_cards_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Sections { about, lyrics }

class SongScreen extends StatefulWidget {
  SongScreen({
    required this.country,
    required this.singer,
    required this.song,
    required this.link,
    required this.about,
  });
  final String country;
  final String singer;
  final String song;
  final String link;
  final String about;
  final bool bottomButtonIsVisible = false;

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

  String videoID(String link){
    String _a = link.split('/')[3].split('?')[0];
    print('videoID: $_a');
    return _a;
  }
  late final _controller = YoutubePlayerController.fromVideoId(
    videoId: videoID(link),
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );
  List<Widget> columnWidgetList = <Widget>[];

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  String lyrics = '';
  bool lyricsAreActivated = false;
  bool nextButtonWasPressed = false;

  Sections selected = Sections.about;
  Future<void> fetchLyrics() async {
    if (lyricsAreActivated == true) {
      return;
    }
    final Uri apiUrl = Uri(
        path: '/v1/${widget.singer}/${widget.song}',
        scheme: 'https',
        host: 'api.lyrics.ovh');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      setState(() {
        lyrics = json.decode(response.body)['lyrics'];
      });
    } else {
      throw Exception('Failed to load lyrics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eurovision 2024'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                      'assets/flagsBlack/ESC-HEART-${widget.country}-BLACK.png'),
                  const SizedBox(
                    width: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      widget.countryText(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: kDefaultGradient,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(kBorderRadius),
                            ),
                            child: Image.asset(
                              'assets/singers/${widget.country}-SINGER.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                children: [
                                  const Text(
                                    'artist  ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                        widget.singer.replaceAll('\n', ' '),
                                        style: kSongAndArtistTextStyle),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                children: [
                                  const Text(
                                    'song title  ',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        widget.song,
                                        style: kSongAndArtistTextStyle,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(kBorderRadius),
                    ),
                    child: YoutubePlayer(
                      controller: widget._controller,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SegmentedButton(
                          style: const ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ))),
                          segments: const [
                            ButtonSegment(
                              value: Sections.about,
                              label: Text('About'),
                              icon: Icon(Icons.question_mark),
                            ),
                            ButtonSegment(
                              value: Sections.lyrics,
                              label: Text('Lyrics'),
                              icon: Icon(Icons.lyrics),
                            ),
                          ],
                          selected: <Sections>{selected},
                          onSelectionChanged: (Set<Sections> newSelection) {
                            setState(() {
                              fetchLyrics();
                              selected = newSelection.first;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          selected == Sections.about ? widget.about : lyrics,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.bottomButtonIsVisible,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: DefButton(
                          onPressed: () {
                            if (!nextButtonWasPressed) {
                              rearrangingSongsToAddList.add(
                                SongCardR(
                                  songName: widget.song,
                                  singer: widget.singer,
                                  country: widget.country,
                                  videoLink: widget.link,
                                  info: widget.about,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

