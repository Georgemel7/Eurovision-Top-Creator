import 'dart:async';

import 'package:eurovision_top_creator/components/next_button.dart';
import 'package:eurovision_top_creator/constants.dart';
import 'package:eurovision_top_creator/screens/song_cards_view_screen.dart';
import 'package:eurovision_top_creator/song_cards_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import '../components/song_card.dart';

List<SongCard> getSongCardsByCountry(List<String> countries) {
  List<SongCard> list = <SongCard>[];
  for (int countryIndex = 0;
      countryIndex <= countries.length - 1;
      countryIndex++) {
    int k = 0;
    bool endSearch = false;
    while (!endSearch) {
      if (songCards[k].country == countries[countryIndex].toUpperCase()) {
        list.add(songCards[k]);
        endSearch = true;
      } else if (k == songCards.length) {
        list.add(SongCard(
          songName: 'error',
          singer: 'error',
          country: 'error',
          videoLink: '',
          info: 'error',
        ));
        endSearch = true;
      }
      k++;
    }
  }
  return list;
}

class TimeAndDate {
  TimeAndDate(
      {required this.day,
      required this.month,
      required this.year,
      required this.second,
      required this.hour,
      required this.minute});
  final int day;
  final int month;
  final int year;
  final int second;
  final int hour;
  final int minute;

  int getTimeInSeconds() =>
      second +
      minute * 60 +
      hour * 3600 +
      day * 24 * 3600 +
      (month * 31 - getMonthsInSecondsCalcBias(month)) * 24 * 3600 +
      year ~/ 4 * 366 * 24 * 3600 +
      (year - (year ~/ 4)) * 365 * 24 * 3600;
  int getTimeInDays() =>
      day +
      month * 31 -
      getMonthsInSecondsCalcBias(month) +
      year ~/ 4 * 366 +
      (year - (year ~/ 4)) * 365;
}

class TimeForTimer {
  TimeForTimer(
    this.second,
    this.minute,
    this.hour,
    this.day,
  );
  late int day;
  late int second;
  late int hour;
  late int minute;
  int getSecond() {
    if (second < 0) {
      second = 59;
    } else if (second == 0) {
      minute--;
    }
    return second;
  }

  int getMinute() {
    if (minute < 0) {
      minute = 59;
    } else if (minute == 0 && second == 0) {
      hour--;
    }
    return minute;
  }

  int getHour() {
    if (hour < 0) {
      hour = 23;
    } else if (hour == 0 && minute == 0 && second == 0) {
      day--;
    }
    return hour;
  }

  int getDay() {
    return day;
  }
}

int getMonthsInSecondsCalcBias(int months) {
  if (months == 1) {
    return 0;
  } else if (months >= 2 && months <= 3) {
    return 2;
  } else if (months >= 4 && months <= 5) {
    return 3;
  } else if (months >= 6 && months <= 8) {
    return 4;
  } else if (months >= 9 && months <= 10) {
    return 5;
  } else {
    return 6;
  }
}

class SongContest extends StatefulWidget {
  const SongContest({super.key});

  @override
  State<SongContest> createState() => _SongContestState();
}

class _SongContestState extends State<SongContest> {
  TimeForTimer timeForTimer(TimeAndDate current, TimeAndDate target) {
    int second = target.second - current.second;
    int minute = target.minute - current.minute;
    int hour = target.hour - current.hour;
    int day = target.getTimeInDays() - current.getTimeInDays();
    int getSecond() {
      if (second < 0) {
        second += 60;
        minute--;
      }
      return second;
    }

    int getMinute() {
      if (minute < 0) {
        minute += 60;
        hour--;
      }
      return minute;
    }

    int getHour() {
      if (hour < 0) {
        hour += 24;
        day--;
      }
      return hour;
    }

    return TimeForTimer(
      getSecond(),
      getMinute(),
      getHour(),
      day,
    );
  }

  Map<int, String> month = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
  List<String> finalParticipants = <String>[
    'Germany',
    'United Kingdom',
    'France',
    'Spain',
    'Switzerland'
  ];
  TimeAndDate finalTime = TimeAndDate(
      day: 10, month: 5, year: 2025, second: 0, hour: 21, minute: 0);
  TimeAndDate currentTime = TimeAndDate(
      day: DateTime.now().day,
      month: DateTime.now().month,
      year: DateTime.now().year,
      second: DateTime.now().second,
      hour: DateTime.now().hour,
      minute: DateTime.now().minute);
  late TimeForTimer time = timeForTimer(currentTime, finalTime);
  static const TextStyle numTextStyle =
      TextStyle(color: Colors.white, fontSize: 40);
  static const TextStyle timeTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30);
  void startTimer() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      setState(() {
        time.second--;
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Stack(alignment: Alignment.center, children: [
            AspectRatio(
              aspectRatio: 27 / 18,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kOutlineBorderRadius),
                child: Image.asset(
                  'assets/other/back.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < finalParticipants.length; i++)
                        i == 2 ? Stack(
                          children: [
                            CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/singers/${finalParticipants[i].toUpperCase()}-SINGER.jpg'),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withOpacity(1),
                                    ],
                                  ),
                                ),),
                          ],
                        ) : Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/singers/${finalParticipants[i].toUpperCase()}-SINGER.jpg'),
                            ),
                          ),
                      const Text(
                        'Final',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    '${finalTime.day} ${month[finalTime.month]}, ${finalTime.year} ${finalTime.hour}:${finalTime.minute} CET',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: '${time.getDay()}', style: numTextStyle),
                    const TextSpan(text: 'd ', style: timeTextStyle),
                    TextSpan(text: '${time.getHour()}', style: numTextStyle),
                    const TextSpan(text: 'h ', style: timeTextStyle),
                    TextSpan(text: '${time.getMinute()}', style: numTextStyle),
                    const TextSpan(text: 'm ', style: timeTextStyle),
                    TextSpan(text: '${time.getSecond()}', style: numTextStyle),
                    const TextSpan(text: 's', style: timeTextStyle),
                  ])),
                  const SizedBox(
                    height: 20,
                  ),
                  DefButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongCardsViewScreen(
                            title: 'Final Participants',
                            list: getSongCardsByCountry(finalParticipants),
                          ),
                        ),
                      );
                    },
                    text: 'See participants',
                    height: 65,
                  )
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
