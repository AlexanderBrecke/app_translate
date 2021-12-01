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
    final input = provider.textFieldController.text;

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
                    _translationTop(provider),
                    _translateText(input),
                    SizedBox(height: 1/50 * MediaQuery.of(context).size.height),
                    _fromText(input),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _translateText(String input){
    return Text(
        input,
      style: kTranslationTextStyle(14.0, FontWeight.normal),
    );
  }

  Widget _translationTop(AppDataModel provider){
    return Row(
      children: [
        Text(
            provider.toLanguage.toName(),
          style: kTranslationTextStyle(16.0, FontWeight.w200),

        ),
        Spacer(),
        IconButton(icon: kStarEmpty, color:Colors.white, onPressed: (){

        }),
      ],
    );
  }
}

Widget _fromText(String input){
  return Text(
    input,
    style: kTranslationTextStyle(10.0, FontWeight.w200),
  );
}
