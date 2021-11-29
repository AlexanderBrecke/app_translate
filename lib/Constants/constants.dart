import 'package:flutter/material.dart';

final kAppTheme = ThemeData.light().copyWith(
  highlightColor: Colors.green,
);

enum kToOrFrom{
  TO,
  FROM,
}

// icons

Icon kChangeIcon = const Icon(Icons.autorenew_outlined);
Icon kStarEmpty = const Icon(Icons.star_outline);
Icon kStarFilled = const Icon(Icons.star);

// ---