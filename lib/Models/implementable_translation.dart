import 'package:translate/Models/implementable_language.dart';
import 'package:translator/translator.dart';

// This was created because we could not encode and decode the Translation class from translator dependency.
class ImplementableTranslation{
  late final String text;
  late final String source;
  late final ImplementableLanguage sourceLanguage;
  late final ImplementableLanguage targetLanguage;

  ImplementableTranslation(this.text, this.source, this.sourceLanguage, this.targetLanguage);

  ImplementableTranslation.fromTranslation(Translation translation){
    this.text = translation.text;
    this.source = translation.source;
    this.sourceLanguage = ImplementableLanguage.fromLanguage(translation.sourceLanguage);
    this.targetLanguage = ImplementableLanguage.fromLanguage(translation.targetLanguage);
  }

  ImplementableTranslation.fromJson(Map<String,dynamic> json)
  : text = json["text"],
  source = json["source"],
  sourceLanguage = ImplementableLanguage.fromJson(json["sourceLanguage"]),
  targetLanguage = ImplementableLanguage.fromJson(json["targetLanguage"]);

  Map<String,dynamic> toJson() => {
    "text" : text,
    "source" : source,
    "sourceLanguage": sourceLanguage.toJson(),
    "targetLanguage": targetLanguage.toJson(),
  };


}
