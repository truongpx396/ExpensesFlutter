import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:quiver/async.dart';

class PKCEPage extends StatefulWidget {
  final auth;
  final Function showInfo;
  const PKCEPage(this.auth, this.showInfo);
  @override
  _PKCEPageState createState() => _PKCEPageState();
}

class _PKCEPageState extends State<PKCEPage> with WidgetsBindingObserver {
  bool webLogged;
  dynamic currentWebAuth;

  bool keepingAppFlag;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //listenIntentData();
    webLogin();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // webLogin();
      //Navigator.popUntil(context, (route) => false);
      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      startTimer();
    }
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: 0),
      new Duration(seconds: 2),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if (duration.elapsed.inSeconds >= 1) {
        if (!keepingAppFlag) exit(0);
      }
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  Auth0 get auth {
    return widget.auth;
  }

  Function get showInfo {
    return widget.showInfo;
  }

  void webLogin() async {
    keepingAppFlag = false;
    try {
      var response = await auth.webAuth.authorize({
        'audience': 'erpapi',
        // 'scope': 'openid email offline_access',
        'scope': 'openid profile email',
      });

      //var userInfo = await auth.auth.getUserInfo();

      keepingAppFlag = true;

      DateTime now = DateTime.now();
      // showInfo('Web Login', '''
      // \ntoken_type: ${response['token_type']}
      // \nexpires_in: ${DateTime.fromMillisecondsSinceEpoch(response['expires_in'] + now.millisecondsSinceEpoch)}
      // \nindentityToken: ${response['id_token']}
      // \nrefreshToken: ${response['refresh_token']}
      // \naccess_token: ${response['access_token']}
      // ''');

//      await MySharedPreference.init();
//
//      MySharedPreference.setIdToken(response['id_token']);
//      APIConfiguration.IdAccessToken = MySharedPreference.getIdToken();
//
//      final Map<String, dynamic> decClaimSet = parseJwt(response['id_token']);
//
//      MySharedPreference.setLoginUserEmail(decClaimSet['email']);
//
//      MySharedPreference.setLoginUserName(decClaimSet['name']);
//
//      MySharedPreference.setLoginUserPicture(decClaimSet['picture']);

      webLogged = true;
      currentWebAuth = Map.from(response);
      setState(() {});

//      Navigator.pushNamedAndRemoveUntil(
//          context, MainScreen.baseRoute, (route) => false);
    } catch (e) {
      print('Error: $e');
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  void webRefreshToken() async {
    try {
      var response = await auth.webAuth.client.refreshToken({
        'refreshToken': currentWebAuth['refresh_token'],
      });
      DateTime now = DateTime.now();
//    showInfo('Refresh Token', '''
//      \ntoken_type: ${response['token_type']}
//      \nexpires_in: ${DateTime.fromMillisecondsSinceEpoch(response['expires_in'] + now.millisecondsSinceEpoch)}
//      \naccess_token: ${response['access_token']}
//      ''');
    } catch (e) {
      print('Error: $e');
    }
  }

  void closeSessions() async {
    try {
      await auth.webAuth.clearSession();
      webLogged = false;
      setState(() {});
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white,
      child: Center(child: Icon(Icons.star)),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     MaterialButton(
      //       color: Colors.lightBlueAccent,
      //       textColor: Colors.white,
      //       child: const Text('Test Login'),
      //       onPressed: !webLogged ? webLogin : null,
      //     ),
      //     MaterialButton(
      //       color: Colors.blueAccent,
      //       textColor: Colors.white,
      //       child: const Text('Test Refresh Token'),
      //       onPressed: webLogged ? webRefreshToken : null,
      //     ),
      //     MaterialButton(
      //       color: Colors.redAccent,
      //       textColor: Colors.white,
      //       child: const Text('Test Clear Sessions'),
      //       onPressed: webLogged ? closeSessions : null,
      //     ),
      //   ],
      // ),
    );
  }
}
