import 'dart:async';
import 'package:flutter_auth0/flutter_auth0.dart';

class AuthClient {
  final String clientId, domain;
  Auth0 authClient;

  AuthClient(
      {this.authClient,
      this.clientId: 'DFdb6hTN3KyEpvSOK9Uar96fCQ5f2FQ6',
      this.domain: 'auth.mantu.com'}) {
    if (authClient == null) {
      authClient = Auth0(baseUrl: 'https://$domain/', clientId: clientId);
    }
  }

  Future<dynamic> getUserInfo(accessToken) async {
    if (accessToken == null) {
      return null;
    }
    try {
      var client = Auth0Auth(
          authClient.auth.clientId, authClient.auth.client.baseUrl,
          bearer: 'user access_token');
      return Map.from(await client.getUserInfo());
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> refreshToken(refreshToken) async {
    if (refreshToken == null) {
      return null;
    }
    try {
      return Map.from(await authClient.webAuth.client.refreshToken({
        'refreshToken': 'user refresh_token',
      }));
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  void closeSessions() {
    authClient.webAuth.clearSession();
  }

  Future<Map<dynamic, dynamic>> authorize() async {
    try {
      var _result = await authClient.webAuth.authorize({
        'audience': 'erpapi',
        'redirectUri': 'https://qc.mantu.com',
        'responseType': 'Access Token',
        'scope': 'openid email profile',
      });
      var res = Map.from(_result);
      if (res.containsKey('access_token')) {
        return res;
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
