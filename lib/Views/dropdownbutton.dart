import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Constants/language_list.dart';
import 'package:translate/Models/app_data_model.dart';

// View to create a dropdown button
class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(this._toOrFrom, {Key? key}) : super(key: key);
  
  final kToOrFrom _toOrFrom;

  @override
  Widget build(BuildContext context) {
    return _dropDownButton(context);
  }

  // Function to create the button
  Widget _dropDownButton(BuildContext context){

    var provider = Provider.of<AppDataModel>(context);

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(

            hint: _toOrFrom == kToOrFrom.TO ? Text(provider.toLang.name) : Text(provider.fromLang.name),

            //populate the items from list of languages
            items: kLangs.values.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),

            // Set language in the provider according to what was chosen
            onChanged: (newValue){
              if(newValue != null){
                var lang = provider.getLanguageFromString(newValue.toString());
                if(_toOrFrom == kToOrFrom.TO){
                  provider.setLanguage(_toOrFrom, lang);
                } else {
                  provider.setLanguage(_toOrFrom, lang);
                }
              }
            },

          ),
        ),
      ),
    );
  }
}


