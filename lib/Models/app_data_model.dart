import 'package:flutter/material.dart';
import 'package:translate/Constants/constants.dart';

class AppDataModel extends ChangeNotifier{

  // Language handling

  kSupportedLanguages fromLanguage = kSupportedLanguages.Norwegian;
  kSupportedLanguages toLanguage = kSupportedLanguages.Norwegian;

  void setLanguage(kToOrFrom toOrFrom, kSupportedLanguages lang){

    if(toOrFrom == kToOrFrom.TO){
      toLanguage = lang;
    } else {
      fromLanguage = lang;
    }
    notifyListeners();
  }

  void switchLanguages(){
    kSupportedLanguages from = fromLanguage;
    kSupportedLanguages to = toLanguage;

    if(from != to){
      fromLanguage = to;
      toLanguage = from;
      notifyListeners();
    }
  }

  kSupportedLanguages getLanguage(String lang){
    String languages = "kSupportedLanguages.";
    return kSupportedLanguages.values.firstWhere((e) => e.toString() == languages+lang);
  }

  // ---


  // Input handling

  final textFieldController = TextEditingController();

  void foo(String input){
    print(textFieldController.text);
    notifyListeners();
  }

  // ---

}