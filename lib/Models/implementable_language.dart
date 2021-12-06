
import 'package:translator/src/langs/language.dart';


class ImplementableLanguage{

  late final String code;
  late final String name;

  ImplementableLanguage(this.code, this.name);

  ImplementableLanguage.fromLanguage(Language language){
    this.code = language.code;
    this.name = language.name;
  }

  ImplementableLanguage.fromJson(Map<String,dynamic> json)
  : code = json["code"],
  name = json["name"];


  Map<String,dynamic> toJson() => {
    "code" : code,
    "name" : name,
  };

}