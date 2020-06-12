import 'package:expenses_mobile/model/app/app_state.dart';
import 'package:expenses_mobile/view/pages/home/home_page.dart';
import 'package:expenses_mobile/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var appState = AppStateModel(prefs);
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateTitle: (context) => 'Expenses',
    home: new ChangeNotifierProvider.value(
      value: appState,
      child: new HomePage(
        title: 'Expenses',
      ),
    ),
    routes: <String, WidgetBuilder>{
      "/HomePage": (BuildContext context) => new ChangeNotifierProvider.value(
            value: appState,
            child: new HomePage(),
          ),
      "/LoginPage": (BuildContext context) => new ChangeNotifierProvider.value(
            value: appState,
            child: new LoginPage(),
          ),
    },
  ));
}
