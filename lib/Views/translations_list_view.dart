import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';
import 'package:translate/Models/translation_model.dart';

// View to show the history list of translations
class TranslationsListView extends StatelessWidget {
  const TranslationsListView(this.showHistory, {Key? key}) : super(key: key);

  final bool showHistory;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppDataModel>(context);
    return Flexible(
      child: ListView(
        children: showHistory ? provider.history.reversed.map((e) => _buildHistory(e, context)).toList() :
            provider.favorites.reversed.map((e) => _buildHistory(e, context)).toList(),
      ),
    );
  }

  // Function to create the list tile that goes in the list
  // Make it dismissible so we can delete items from the history
  Widget _buildHistory(TranslationModel model, BuildContext context){
    var provider = Provider.of<AppDataModel>(context, listen: false);
    return Dismissible(
      key: Key(model.translation.text),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        showHistory ?
            provider.deleteFromList(model, provider.history) :
            provider.deleteFromList(model, provider.favorites);
      },
      background: Container(
        color: Colors.redAccent,
        padding: EdgeInsets.only(right: 16.0),
        alignment: Alignment.centerRight,
        child: kDeleteIcon,
      ),

      child: ListTile(
        title: Text(model.translation.text,
          maxLines: 3,
        ),
        subtitle: Text(model.translation.source,
          maxLines: 3,
        ),
        trailing: IconButton(
          onPressed: (){
            provider.changeFavoriteStatus(model);
          },
          icon: model.isFavorite ?
            kStarFilledIcon :
            kStarEmptyIcon,
        ),
        onTap: (){
          provider.setCurrentTranslationModel(model);
        },
      ),
    );
  }

}
