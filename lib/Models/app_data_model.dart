import 'package:flutter/material.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/translation_model.dart';
import 'package:translator/translator.dart';

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

  // ---


// translation handling

  final translator = GoogleTranslator();
  Translation? currentTranslation;

  void translate(String input){

    if(textFieldController.text != ""){
      translator.translate(textFieldController.text, from: fromLanguage.getValue(), to: toLanguage.getValue()).then((value) {
        currentTranslation = value;
        _addToHistory(value);
        notifyListeners();
      });
    } else {
      currentTranslation = null;
      notifyListeners();
    }

  }


// ---

// translation history

  List<TranslationModel> history = [];

  void _addToHistory(Translation translation){
    history.add(TranslationModel(translation));
    print(history.length);
    notifyListeners();
  }

// ---

}