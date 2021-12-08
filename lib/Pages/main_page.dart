import 'package:flutter/material.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';
import 'package:translate/Views/dropdownbutton.dart';
import 'package:translate/Views/history_list_view.dart';
import 'package:translate/Views/input_card_view.dart';
import 'package:translate/Views/translation_card_view.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // --- Page ---
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(),
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

            // Only show history if there is any to show
            if(Provider.of<AppDataModel>(context).history.length > 0) ... [
              HistoryListView(),
            ],

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
