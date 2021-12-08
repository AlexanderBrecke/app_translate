import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';

// Card view for the translation
class TranslationCard extends StatelessWidget {
  const TranslationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _translationCard(context);
  }

  // Function for creating the card
  Widget _translationCard(BuildContext context){

    final provider = Provider.of<AppDataModel>(context);

    return Card(
      color: Colors.blue[600],
      child: Container(

        height: (1/5 * MediaQuery.of(context).size.height),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _languageTitle(provider),
                  _translationText(provider),
                  SizedBox(height: 1/100 * MediaQuery.of(context).size.height),
                  _sourceText(provider),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  //Function to set the language title
  Widget _languageTitle(AppDataModel provider){
    return Row(
      children: [
        Text(
          provider.currentTranslationModel!.translation.targetLanguage.name,
          style: kTranslationTextStyle(14.0, FontWeight.w300),
        ),
        Spacer(),

        IconButton(onPressed:() {
          provider.setFavorite(provider.currentTranslationModel!);
        }, icon: provider.currentIsFavorite() ? kStarFilledIcon : kStarEmptyIcon),
      ],
    );
  }

  // Function to set the translation text
  Widget _translationText(AppDataModel provider){
    return Text(
        provider.currentTranslationModel!.translation.text,
      style: kTranslationTextStyle(14.0, FontWeight.normal),
    );
  }

  // Function to set the source text
  Widget _sourceText(AppDataModel provider){
    return Text(
      provider.currentTranslationModel!.translation.source,
      style: kTranslationTextStyle(10.0, FontWeight.w300),
    );
  }

}


