import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  InternetConnectivity._();

  static final _instance = InternetConnectivity._();
  static InternetConnectivity get instance => _instance;

  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  Future<void> initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) async {
      await Future.delayed(Duration(milliseconds: 200));
      _checkStatus(result);
    });
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = await hasInternet();
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
