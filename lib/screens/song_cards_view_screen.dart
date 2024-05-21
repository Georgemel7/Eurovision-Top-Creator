import 'package:eurovision_top_creator/song_cards_list.dart';
import 'package:flutter/material.dart';
class SongCardsViewScreen extends StatefulWidget {
  const SongCardsViewScreen({required this.title, required this.list});
  final String title;
  final List<Widget> list;
  @override
  State<SongCardsViewScreen> createState() => _SongCardsViewScreenState();
}

class _SongCardsViewScreenState extends State<SongCardsViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: widget.list,
      ),
    );
  }
}
