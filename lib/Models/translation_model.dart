import 'package:translator/translator.dart';

class TranslationModel{
  final Translation translation;
  bool isFavorite = false;

  TranslationModel(this.translation);

  void setFavorite(){
    isFavorite = !isFavorite;
  }


}