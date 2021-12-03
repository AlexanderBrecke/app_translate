import 'package:translator/translator.dart';

class TranslationModel{
  final Translation translation;
  bool isFavorite = false;

  TranslationModel(this.translation);

  void setFavorite(){
    isFavorite = !isFavorite;
  }

  static TranslationModel fromJson2(dynamic json) {
    return TranslationModel(json["translation"]);
  }

  TranslationModel.fromJson(Map<String, dynamic> json)
      : translation = json["translation"],
        isFavorite = json["isFavorite"];

  Map<String, dynamic> toJson() => {
    "translation": {
      "text": translation.text,
      "source": translation.source,
      "targetLanguage": translation.targetLanguage,
      "sourceLanguage": translation.sourceLanguage
    },
    'isFavorite': isFavorite,
  };
}