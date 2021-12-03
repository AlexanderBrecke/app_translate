import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';
import 'package:translate/Models/translation_model.dart';

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

  Widget _buildHistory(TranslationModel model, BuildContext context){
    var provider = Provider.of<AppDataModel>(context, listen: false);
    return ListTile(
      title: Text(model.translation.text),
      subtitle: Text(model.translation.source),
      trailing: model.isFavorite ? IconButton(onPressed: () {
        provider.setFavorite(model);
      }, icon: kStarFilled) : IconButton(onPressed: (){
        provider.setFavorite(model);
      }, icon: kStarEmpty),
    );
  }

}
