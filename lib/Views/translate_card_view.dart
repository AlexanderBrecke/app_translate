import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';

class TranslateCard extends StatelessWidget {
  const TranslateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _translationCard(context);
  }

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
  
  Widget _translationText(AppDataModel provider){
    return Text(
        provider.currentTranslation!.text,
      style: kTranslationTextStyle(14.0, FontWeight.normal),
    );
  }

  Widget _languageTitle(AppDataModel provider){
    return Row(
      children: [
        Text(
          provider.currentTranslation!.targetLanguage.name,
          style: kTranslationTextStyle(14.0, FontWeight.w300),
        ),
        Spacer(),
        IconButton(icon: kStarEmpty, color:Colors.white, onPressed: (){

        }),
      ],
    );
  }

  Widget _sourceText(AppDataModel provider){
    return Text(
      provider.currentTranslation!.source,
      style: kTranslationTextStyle(10.0, FontWeight.w300),
    );
  }

}


