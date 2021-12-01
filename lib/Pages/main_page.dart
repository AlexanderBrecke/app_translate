import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translator/translator.dart';

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


  // --- Languages ---

  String _fromLanguage = "";
  String _toLanguage = "";

  // --- ---


  // --- Controllers ---

  final _textFieldController = TextEditingController();

  // --- ---



  bool _isLoading = true;

  SharedPreferences? _prefs;




  @override
  void initState() {
    initializeLanguages();
    _loadSharedPrefs();
    super.initState();
  }

  // --- Logic functions ---

  void initializeLanguages(){
    _fromLanguage = kSupportedLanguages.Norwegian.toName();
    _toLanguage = kSupportedLanguages.Norwegian.toName();
  }

  void _loadSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      _isLoading = false;
    });
  }

  void _switchLanguage(){
    var to = _toLanguage;
    var from = _fromLanguage;

    if(to != from){
      setState(() {
        _toLanguage = from;
        _fromLanguage = to;
      });
    }
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
                _dropDownButton(kToOrFrom.FROM),
                IconButton(icon: kChangeIcon, onPressed: () {
                  _switchLanguage();
                }),
                _dropDownButton(kToOrFrom.TO),
              ],
            ),
            Divider(),


            _searchField(),
            Divider(),

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
    );
  }

  Widget _dropDownButton(kToOrFrom toOrFrom){

    var suppLang = kSupportedLanguages.values.map((e) => e.toName()).toList();

    String hint = "";
    if(toOrFrom == kToOrFrom.TO){
      hint = _toLanguage;
    } else {
      hint = _fromLanguage;
    }

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(

            isExpanded: true,
            style: TextStyle(color: Colors.blueGrey),

            hint: Text(hint),
              items: suppLang.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            onChanged: (newValue){
              if(newValue != null){
                setState(() {
                  if(toOrFrom == kToOrFrom.TO){
                    _toLanguage = newValue.toString();
                    print(_toLanguage);
                  } else {
                    _fromLanguage = newValue.toString();
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _searchField(){
    return Card(
      elevation: 0.0,
      child: TextField(
        maxLines: 5,
        controller: _textFieldController,
        onChanged: _foo,

        // textInputAction: TextInputAction.done,
        autocorrect: false,
        // decoration: InputDecoration(
        //   hintText: "Input to search",
        // ),
      ),
    );
  }

  // --- ---


}
