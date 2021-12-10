import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Constants/language_list.dart';
import 'package:translate/Models/implementable_language.dart';
import 'package:translate/Models/implementable_translation.dart';
import 'package:translate/Models/translation_model.dart';
import 'package:translator/translator.dart';

class AppDataModel extends ChangeNotifier{

  // Initialize the data model
  AppDataModel(){
    initializeLanguages();
    readFromSharedPrefs();
  }

// Language handling

  late ImplementableLanguage fromLang;
  late ImplementableLanguage toLang;

  void initializeLanguages(){
    fromLang = getLanguageFromString("Automatic");
    toLang = getLanguageFromString("English");
  }

  void setLanguage(kToOrFrom toOrFrom, ImplementableLanguage lang){
    toOrFrom == kToOrFrom.TO ? toLang = lang : fromLang = lang;
    notifyListeners();
  }

  void switchLanguages(){
    ImplementableLanguage newFrom = fromLang;
    ImplementableLanguage newTo = toLang;

    if(newFrom  != newTo){
      fromLang = newTo;
      toLang = newFrom;
    }
    notifyListeners();
  }

  ImplementableLanguage getLanguageFromString(String input){
    var entry = kLangs.entries.firstWhere((element) => element.value == input);
    return ImplementableLanguage(entry.key, entry.value);
  }

// ---


// translation

  final textFieldController = TextEditingController();

  final translator = GoogleTranslator();

  TranslationModel? currentTranslationModel;
  
  void throttledTranslate(String input){
    Future.delayed(const Duration(milliseconds: 500), () {
      if(input == textFieldController.text){
        _runTranslationCheck(input);
      }
    });

  }

  void _runTranslationCheck(String input){
    currentTranslationModel != null ? {
      if(currentTranslationModel!.translation.source != input){
        _translate(input),
      }
    }
    : {
      _translate(input)
    };
  }

  void _translate(String input){

    if(textFieldController.text != ""){

      translator.translate(input, from: fromLang.code, to: toLang.code).then((value) {
        TranslationModel model = TranslationModel(ImplementableTranslation.fromTranslation(value));
        currentTranslationModel = model;
        notifyListeners();
      });
    } else {
      currentTranslationModel = null;
      notifyListeners();
    }

  }

  void setCurrentTranslationModel(TranslationModel newCurrent){
    currentTranslationModel = newCurrent;
    notifyListeners();
  }

// ---


// translation history

  List<TranslationModel> history = [];

  void historyAdd(){
    if(currentTranslationModel != null && !currentIsInHistory()){
      _addToHistory(currentTranslationModel!);
    }
    notifyListeners();
  }

  void _addToHistory(TranslationModel translation){
    history.add(translation);
    saveToSharedPrefs();
    notifyListeners();
  }

  void historyRemove(TranslationModel translation){
    history.removeWhere((element) => element == translation);
    print(history.isEmpty);
    if(history.isEmpty && textFieldController.text == ""){
      currentTranslationModel = null;
    }
    saveToSharedPrefs();
    notifyListeners();
  }

  bool currentIsInHistory() => history.contains(currentTranslationModel);

// ---


// favorite handling

  bool currentIsFavorite() => currentTranslationModel!.isFavorite;

  void setFavorite(TranslationModel translationModel){
    // if(translationModel == currentTranslationModel){
    //
    // }
    if(history.contains(translationModel)){
      history[history.indexOf(translationModel)].setFavorite();
    } else {
      _addToHistory(translationModel);
      setFavorite(translationModel);
    }
    // translationModel.setFavorite();
    // if(translationModel.isFavorite){
    //   _addFavorite(translationModel);
    // }
    // else{
    //   _removeFavorite(translationModel);
    // }
    //
    // print(favorites);
    // print(history);

    saveToSharedPrefs();
    notifyListeners();
  }

  // void _addFavorite(TranslationModel translationModel){
  //   if(history.contains(translationModel)){
  //     history.remove(translationModel);
  //   }
  //   favorites.add(translationModel);
  // }
  //
  // void _removeFavorite(TranslationModel translationModel){
  //   if(favorites.contains(translationModel)){
  //     favorites.remove(translationModel);
  //   }
  //   history.add(translationModel);
  // }

  // void addToFavorite(TranslationModel translationModel){
  //   if(history.contains(translationModel)) {
  //     translationModel.setFavorite();
  //     favorites.add(translationModel);
  //     history.remove(translationModel);
  //   } else {
  //     _addToHistory(translationModel);
  //     addToFavorite(translationModel);
  //   }
  // }



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
    prefs.setString(kHistoryKey, encodedHistory);
  }

// ---

}