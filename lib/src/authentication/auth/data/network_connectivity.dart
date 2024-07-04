import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

class InternetConnectivity {
  final StreamController<bool> _internetStreamController = StreamController<bool>();

  Stream<bool> get internetStream => _internetStreamController.stream;

  InternetConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkInternetConnectivity(result);
    });
    _checkInternetConnectivity(ConnectivityResult.none);
  }

  void _checkInternetConnectivity(ConnectivityResult result) async {
    bool hasInternet = false;
    if (result != ConnectivityResult.none) {
      try {
        final response = await InternetAddress.lookup('google.com');
        if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
          hasInternet = true;
        }
      } catch (_) {
        hasInternet = false;
      }
    }
    _internetStreamController.add(hasInternet);
  }

  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        final response = await InternetAddress.lookup('google.com');
        if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _internetStreamController.close();
  }
}
