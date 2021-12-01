import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/Constants/constants.dart';
import 'package:translate/Models/app_data_model.dart';
import 'package:translate/Pages/main_page.dart';

void main() {
  runApp(TranslateApp());
}

class TranslateApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppDataModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: kAppTheme,
        home: MainPage(),
      ),
    );
  }
}



