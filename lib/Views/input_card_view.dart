import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Models/app_data_model.dart';

class InputCardView extends StatelessWidget {
  const InputCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _searchField(context);
  }

  Widget _searchField(BuildContext context){
    var provider = Provider.of<AppDataModel>(context, listen: false);

    return Card(
      elevation: 0.0,
      child: TextField(
        maxLines: 3,
        controller: provider.textFieldController,
        // onChanged: provider.foo,

        textInputAction: TextInputAction.done,
        onSubmitted: provider.translate,
        autocorrect: false,
      ),
    );
  }
}


