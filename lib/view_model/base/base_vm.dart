import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  bool _busyDialog = false;
  bool get busyDialog => _busyDialog;

  String get errorMessage => _errorMessage;
  String _errorMessage = "";

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void setBusyDialog(bool value) {
    _busyDialog = value;
    notifyListeners();
  }

  void refreshWidget(BuildContext context) {}

  void setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
