import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translate/Models/app_data_model.dart';

class FavoritesOrHistoryChoiceView extends StatelessWidget {
  AppDataModel provider;
  FavoritesOrHistoryChoiceView(this.provider);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Favorites"),
        Switch(
          value: provider.shouldShowHistoryList,
          onChanged: (newValue) => {
            provider.showHistoryList(newValue)
          },
          activeColor: Colors.amber,
          inactiveTrackColor: Colors.green[400],
          inactiveThumbColor: Colors.green,
        ),

        Text("History"),
      ],
    );
  }
}
