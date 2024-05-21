import 'package:eurovision_top_creator/screens/my_top_page.dart';
import 'package:eurovision_top_creator/screens/song_contest_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'overview_screen.dart';
import 'top_song_screen.dart';
int currentPageIndex = 0;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Eurovision 2024'),
        ),
        body: [const OverviewScreen(), const MyTopScreen(), const SongContest()][currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.music_note_rounded),
              label: 'Overview',
            ),
            NavigationDestination(
              icon: Icon(Icons.format_list_numbered_rounded),
              label: 'My Top',
            ),
            NavigationDestination(
                icon: Icon(Icons.mic_rounded),
                label: 'Song Contest'
            ),
          ],
        ),
      ),
    );
  }
}
