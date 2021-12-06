import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/implementable_translation.dart';
import 'package:translate/Models/translation_model.dart';
import 'package:translator/translator.dart';

class AppDataModel extends ChangeNotifier{

  AppDataModel(){
    readFromSharedPrefs();
  }

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

  TranslationModel? currentTranslationModel;
  
  void throttledTranslate(String input){
    Future.delayed(Duration(milliseconds: 500), () {
      if(input == textFieldController.text){
        translate(input);
      } else {
        translate(textFieldController.text);
      }
    });
  }


  void translate(String input){

    if(textFieldController.text != ""){

      translator.translate(textFieldController.text, from: fromLanguage.getValue(), to: toLanguage.getValue()).then((value) {

        currentTranslation = value;
        TranslationModel model = TranslationModel(ImplementableTranslation.fromTranslation(value));
        currentTranslationModel = model;
        notifyListeners();
      });
    } else {
      currentTranslation = null;
      currentTranslationModel = null;
      notifyListeners();
    }

  }

  void historyAdd(){
    if(!history.contains(currentTranslationModel!)){
      _addToHistory(currentTranslationModel!);
      // history.add(currentTranslationModel!);
    }
    notifyListeners();
  }


// ---

// translation history

  List<TranslationModel> history = [];

  void _addToHistory(TranslationModel translation){
    history.add(translation);
    saveToSharedPrefs();
    notifyListeners();
  }

  bool currentIsInHistory(){
    return history.contains(currentTranslationModel);
  }

  bool currentIsFavorite(){
    return currentTranslationModel!.isFavorite;
  }

// ---

// favorite handling

  void setFavorite(TranslationModel translationModel){
    if(history.contains(translationModel)){
      history[history.indexOf(translationModel)].setFavorite();
    } else {
      _addToHistory(translationModel);
      setFavorite(translationModel);
    }
    saveToSharedPrefs();
    notifyListeners();
  }


// ---

// shared prefs

  void readFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString(kHistoryKey);
    if(historyString != null){
      final decodedHistoryString = jsonDecode(historyString);

      final iterableHistory = decodedHistoryString as Iterable<dynamic>;
      history = List<TranslationModel>.of(iterableHistory.map((e) => TranslationModel.fromJson(e)));
      notifyListeners();
    }
    else{
      return;
    }
  }

  void saveToSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var historyStringList = history.map((e) => e.toJson()).toList();

    var encodedHistory = json.encode(historyStringList);
    // print(encodedHistory.runtimeType);
    prefs.setString(kHistoryKey, encodedHistory);


  }



// ---

}