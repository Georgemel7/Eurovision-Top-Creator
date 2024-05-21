import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/song_card_r.dart';

class SavedTopViewScreen extends StatefulWidget {
  const SavedTopViewScreen({required this.list, required this.title});
  final String title;
  final List<SongCardR> list;

  @override
  State<SavedTopViewScreen> createState() => _SavedTopViewScreenState();
}

class _SavedTopViewScreenState extends State<SavedTopViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: ListView(
        children: widget.list,
      )
    );
  }
}
