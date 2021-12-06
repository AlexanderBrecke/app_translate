import 'package:translate/Models/implementable_translation.dart';
import 'package:translator/translator.dart';


class TranslationModel{
  final ImplementableTranslation translation;
  bool isFavorite;


  TranslationModel(this.translation, [this.isFavorite = false]);

  void setFavorite(){
    isFavorite = !isFavorite;
  }

  TranslationModel.fromJson(Map<String,dynamic> json)
    : translation = ImplementableTranslation.fromJson(json["translation"]),
  isFavorite = json["isFavorite"];

  // static TranslationModel fromJson(Map<String, dynamic> json){
  //   return TranslationModel(json["translation"], json["isFavorite"]);
  // }

  static TranslationModel fromJson2(dynamic json) {
    return TranslationModel(json["translation"], json["isFavorite"]);
  }


  Map<String, dynamic> toJson() => {
    'translation': translation.toJson(),
    'isFavorite': isFavorite,
  };
}