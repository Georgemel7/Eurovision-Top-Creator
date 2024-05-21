import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/song_card.dart';
import '../song_cards_list.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: songCards,
    );
  }
}
