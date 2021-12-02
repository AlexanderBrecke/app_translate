import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          children: provider.history.map(_buildHistory).toList(),
        ),
      ),
    );
  }

  Widget _buildHistory(TranslationModel model){
    return ListTile(
      title: Text(model.translation.text),
      subtitle: Text(model.translation.source),
    );
  }

}
