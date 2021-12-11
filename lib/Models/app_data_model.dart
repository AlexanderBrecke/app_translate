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
    _getListFromSharedPrefs("History", kHistoryKey);
    _getListFromSharedPrefs("Favorites", kFavoritesKey);
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


// translation handling

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


// history handling

  bool shouldShowHistoryList = false;
  List<TranslationModel> history = [];


  void showHistoryList(bool newValue){
    shouldShowHistoryList = newValue;
    notifyListeners();
  }

  void historyAdd(){
    if(currentTranslationModel != null && !currentIsInHistory()){
      _addToHistory(currentTranslationModel!);
    }
  }

  void _addToHistory(TranslationModel translation){
    history.add(translation);
    showHistoryList(true);
    _finalizeListChange();
  }

  bool currentIsInHistory() => history.contains(currentTranslationModel);

// ---


// history and favorite mediary

  void _checkIfShouldShowHistory(){
    if(history.isEmpty && favorites.isNotEmpty){
      showHistoryList(false);
    } else if(favorites.isEmpty && history.isNotEmpty){
      showHistoryList(true);
    }
  }

  void _finalizeListChange(){
    _checkIfShouldShowHistory();
    _saveToSharedPrefs();
    notifyListeners();
  }

  void _moveBetweenLists(TranslationModel translationModel, List<TranslationModel> fromList, List<TranslationModel> toList){
    if(fromList.contains(translationModel)){
      fromList.remove(translationModel);
    }
    toList.add(translationModel);
    _finalizeListChange();
  }

  void deleteFromList(TranslationModel translationModel, List<TranslationModel> listToDeleteFrom){
    if(listToDeleteFrom.contains(translationModel)){
      listToDeleteFrom.remove(translationModel);
    }
    if(translationModel == currentTranslationModel){
      currentTranslationModel = null;
    }
    _finalizeListChange();
  }

// ---


// favorite handling

  List<TranslationModel> favorites = [];

  void changeFavoriteStatus(TranslationModel translationModel){
    translationModel.setFavorite();

    translationModel.isFavorite ?
    _moveBetweenLists(translationModel, history, favorites) :
    _moveBetweenLists(translationModel, favorites, history);

    currentTranslationModel = translationModel;
    showHistoryList(!translationModel.isFavorite);
  }

  bool currentIsFavorite() => currentTranslationModel!.isFavorite;

// ---


// shared prefs

  void _getListFromSharedPrefs(String listToGet, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(key);
    if(json != null){
      final decoded = jsonDecode(json);
      final iterable = decoded as Iterable<dynamic>;
      var list = List<TranslationModel>.of(iterable.map((e) => TranslationModel.fromJson(e)));
      if(listToGet == "History"){
        history = list;
      } else if(listToGet == "Favorites") {
        favorites = list;
      }
      _checkIfShouldShowHistory();
      notifyListeners();
    } else {
      return;
    }
  }


  void _saveToSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var historyStringList = history.map((e) => e.toJson()).toList();
    var encodedHistory = json.encode(historyStringList);

    var favoritesStringList = favorites.map((e) => e.toJson()).toList();
    var encodedFavorites = json.encode(favoritesStringList);

    prefs.setString(kHistoryKey, encodedHistory);
    prefs.setString(kFavoritesKey, encodedFavorites);
  }

// ---

}