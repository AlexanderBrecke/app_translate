import 'package:flutter/material.dart';

final kAppTheme = ThemeData.light().copyWith(
  highlightColor: Colors.green,
  primaryColor: Colors.blue[600],
  scaffoldBackgroundColor: Colors.grey[300],
);

final kNewAppTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue[600],
  scaffoldBackgroundColor: Colors.grey[300]
);

enum kToOrFrom{
  TO,
  FROM,
}

// supported languages
enum kSupportedLanguages{
  Norwegian,
  English,
  Danish,

}

extension kLanguageShort on kSupportedLanguages{

  String toName(){
    return toString().split(".").last;
  }

  String getValue(){
    var val = "";
    var language = toName();
    val += (language[0].toLowerCase() + language[1]);
    return val;
  }

  String get value {
    switch(this){
      case kSupportedLanguages.Norwegian:
        return "no";
      case kSupportedLanguages.English:
        return "en";
      case kSupportedLanguages.Danish:
        return "da";
    }
  }
}

// ---


// icons

Icon kChangeIcon = const Icon(Icons.autorenew_outlined);
Icon kStarEmpty = const Icon(Icons.star_outline);
Icon kStarFilled = const Icon(Icons.star);

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