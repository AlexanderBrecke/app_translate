import 'package:flutter/material.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';
import 'package:translate/Views/dropdownbutton.dart';
import 'package:translate/Views/favorites_or_history_choice_view.dart';
import 'package:translate/Views/translations_list_view.dart';
import 'package:translate/Views/input_card_view.dart';
import 'package:translate/Views/translation_card_view.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {

  // --- Page ---
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppDataModel>(context);

    return Scaffold(
      appBar: _appBar(),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                CustomDropDownButton(kToOrFrom.FROM),
                IconButton(icon: kChangeIcon, onPressed: () {
                  Provider.of<AppDataModel>(context, listen: false).switchLanguages();
                }),
                CustomDropDownButton(kToOrFrom.TO),
              ],
            ),
            Divider(),

            InputCardView(),
            Divider(),

            // Only input translation card if we have a current translation
            if(Provider.of<AppDataModel>(context).currentTranslationModel != null) ... [
              TranslationCard(),
              Divider(),
            ],

            // Only show history or favorites if there is anything to show
            if(provider.favorites.length > 0 || provider.history.length > 0) ... [
              if(provider.favorites.isNotEmpty && provider.history.isNotEmpty) ... [
                FavoritesOrHistoryChoiceView(provider)
              ],
              TranslationsListView(provider.shouldShowHistoryList),
            ]

          ],
        ),
      ),
    );
  }

  // --- ---


  // --- Component functions ---

  AppBar _appBar(){
    return AppBar(
      title: Text("Translate"),
      elevation: 0.0,
    );
  }

  // --- ---


}
