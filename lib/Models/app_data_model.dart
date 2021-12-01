import 'package:flutter/material.dart';

class AppDataModel extends ChangeNotifier{

  List<String> supportedLanguages = ["Norwegian", "English", "Danish"];
  String fromLanguage = "";
  String toLanguage = "";

  void switchLanguages(){
    String from = fromLanguage;
    String to = toLanguage;

    if(from != to){
      fromLanguage = to;
      toLanguage = from;
    }
  }

}