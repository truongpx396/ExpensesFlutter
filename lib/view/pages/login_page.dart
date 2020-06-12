import 'package:expenses_mobile/auth/auth.dart';
import 'package:expenses_mobile/auth/pkce.dart';
import 'package:expenses_mobile/model/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:provider/provider.dart';

final String clientId = 'Dsufvww4WRF9XOU4PNvAdjsppNDhvBfL';
final String domain = 'auth.mantu.com';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppStateModel>(context, listen: false);
    var welcomeText = 'Welcome';
    if (appState.authenticated) {
      welcomeText = 'Welcome';
    }
    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        welcomeText,
      ),
    );
    var body;
    if (appState.authenticated) {
      body = Column(
        children: [welcome],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    } else {
      body = Column(
        children: [welcome, AuthPage()],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey, Theme.of(context).primaryColor]),
        ),
        child: body,
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  Auth0 auth;
  @override
  void initState() {
    super.initState();
    auth = Auth0(baseUrl: 'https://$domain', clientId: clientId);
  }

  @override
  Widget build(BuildContext context) {
    return PKCEPage(auth, () {});
  }
}
