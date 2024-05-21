import 'package:flutter/material.dart';

const TextStyle kMainTextStyle = TextStyle(
  fontSize: 25,
);
const LinearGradient kDefaultGradient = LinearGradient(
    colors: [
      Color.fromRGBO(241, 219, 49, 1.0),
      Color.fromRGBO(242, 182, 78, 1.0),
      Color.fromRGBO(246, 151, 114, 1.0),
      Color.fromRGBO(247, 111, 162, 1.0),
      Color.fromRGBO(250, 70, 219, 1.0),
      //add more colors for gradient
    ],
    begin: Alignment.topLeft, //begin of the gradient color
    end: Alignment.bottomRight, //end of the gradient color
    stops: [0, 0.25, 0.4, 0.55, 0.8] //stops for individual color
  //set the stops number equal to numbers of color
);
const TextStyle kSongAndArtistTextStyle = TextStyle(
color: Colors.black,
fontSize: 19,
);
const double kBorderRadius = 15;
const double kOutlineBorderRadius = 20;
const Color kThemeColor = Color.fromRGBO(240, 222, 185, 1.0);