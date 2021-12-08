import 'package:flutter/material.dart';

final kAppTheme = ThemeData.light().copyWith(
  highlightColor: Colors.green,
  primaryColor: Colors.blue[600],
  scaffoldBackgroundColor: Colors.grey[300],
);

enum kToOrFrom{
  TO,
  FROM,
}

// icons

Icon kChangeIcon = const Icon(Icons.autorenew_outlined);
Icon kStarEmptyIcon = const Icon(Icons.star_outline);
Icon kStarFilledIcon = const Icon(Icons.star);
Icon kDeleteIcon = const Icon(Icons.delete);

// ---

// text

TextStyle kTranslationTextStyle(double size, FontWeight weight){
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: Colors.white,
  );
}

// ---

// shared prefs key

String kHistoryKey = "history";

// ---