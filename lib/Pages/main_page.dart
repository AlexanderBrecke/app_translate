import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translator/translator.dart';
import '';

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

  List<String> _supportedLanguages = ["Norwegian", "English", "Danish"];
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

  void _switchLanguage(){
    var to = _toLanguage;
    var from = _fromLanguage;

    if(to != "" && from != ""){
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


      body: Center(



        child: Column(
          children: [


            _searchField(),
            _dropDownButton(_supportedLanguages, kToOrFrom.FROM),
            IconButton(icon: kChangeIcon, onPressed: () {
              _switchLanguage();
            }),
            _dropDownButton(_supportedLanguages, kToOrFrom.TO),
          ],
        ),
      ),
    );
  }

  // --- ---


  // --- Component functions ---

  Widget _dropDownButton(List<String> items, kToOrFrom toOrFrom){
    
    String hint = "";
    if(toOrFrom == kToOrFrom.TO){
      hint = _toLanguage;
    } else {
      hint = _fromLanguage;
    }
    
    return DropdownButton(
      
      hint: hint == ""
      ? Text("Please choose a language")
      : Text(hint),
        items: items.map((String value) {
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
            } else {
              _fromLanguage = newValue.toString();
            }
          });
        }
      },
    );
  }

  Widget _searchField(){
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
      child: TextField(
        controller: _textFieldController,
        onChanged: _foo,

        // textInputAction: TextInputAction.done,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: "Input to search",
        ),
      ),
    );
  }

  // --- ---


}
