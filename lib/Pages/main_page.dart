import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';
import 'package:translate/Views/dropdownbutton.dart';
import 'package:translate/Views/input_card_view.dart';
import 'package:translate/Views/translate_card_view.dart';
import 'package:translator/translator.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // --- Translation ---
  final translator = GoogleTranslator();

  List<Translation> _recentTranslations = [];
  List<Translation> _favoriteTranslations = [];

  // --- ---



  bool _isLoading = true;

  SharedPreferences? _prefs;




  @override
  void initState() {
    _loadSharedPrefs();
    super.initState();
  }

  // --- Logic functions ---

  void _loadSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      _isLoading = false;
    });
  }


  // --- ---



  void _foo(String input){
    print("Text has changed");
  }


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

            if(Provider.of<AppDataModel>(context).textFieldController.text != "") ... [
              TranslateCard(),
              Divider(),
            ]

            //Provider.of<AppDataModel>(context).textFieldController.text != "" ? TranslateCard() : SizedBox(),


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
