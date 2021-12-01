import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(this._toOrFrom, {Key? key}) : super(key: key);
  
  final kToOrFrom _toOrFrom;

  @override
  Widget build(BuildContext context) {
    return _dropDownButton(context);
  }

  Widget _dropDownButton(BuildContext context){

    var suppLang = kSupportedLanguages.values.map((e) => e.toName()).toList();

    var provider = Provider.of<AppDataModel>(context);

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(

            isExpanded: true,
            style: TextStyle(color: Colors.blueGrey),

            hint: _toOrFrom == kToOrFrom.TO ? Text(provider.toLanguage.toName()) : Text(provider.fromLanguage.toName()),
            items: suppLang.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue){
              if(newValue != null){

                var lang = provider.getLanguage(newValue.toString());

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


