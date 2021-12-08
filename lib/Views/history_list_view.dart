import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';
import 'package:translate/Models/translation_model.dart';

// View to show the history list of translations
class HistoryListView extends StatelessWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppDataModel>(context);
    return Expanded(
      child: Card(
        child: ListView(
          children: provider.history.reversed.map((e) => _buildHistory(e, context)).toList(),
          //provider.history.map(_buildHistory).toList(),
        ),
      ),
    );
  }

  // Function to create the list tile that goes in the history list
  // Make it dismissible so we can delete items from the history
  Widget _buildHistory(TranslationModel model, BuildContext context){
    var provider = Provider.of<AppDataModel>(context, listen: false);
    return Dismissible(
      key: Key(model.translation.text),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        provider.historyRemove(model);
      },
      background: Container(
        color: Colors.redAccent,
        padding: EdgeInsets.only(right: 16.0),
        alignment: Alignment.centerRight,
        child: kDeleteIcon,
      ),

      child: ListTile(
        title: Text(model.translation.text),
        subtitle: Text(model.translation.source),
        trailing: model.isFavorite ? IconButton(onPressed: () {
          provider.setFavorite(model);
        }, icon: kStarFilledIcon) : IconButton(onPressed: (){
          provider.setFavorite(model);
        }, icon: kStarEmptyIcon),
        onTap: (){
          provider.setCurrentTranslationModel(model);
        },

      ),
    );
  }

}
