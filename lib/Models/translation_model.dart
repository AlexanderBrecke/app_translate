import 'package:translate/Models/implementable_translation.dart';

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

  Map<String, dynamic> toJson() => {
    'translation': translation.toJson(),
    'isFavorite': isFavorite,
  };
}