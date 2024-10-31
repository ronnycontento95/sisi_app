import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

enum ConnectivityStatus {
  online,
  offline,
  none,
}


class NetworkStatus {
  static final NetworkStatus _singleton = NetworkStatus._internal();

  NetworkStatus._internal();

  factory NetworkStatus() => _singleton;

  ConnectivityStatus hasConnection = ConnectivityStatus.none;

  late StreamSubscription<ConnectivityResult> _connectionSubscription;

  final Connectivity _connectivity = Connectivity();

  void init() {
    _connectionSubscription = _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream<ConnectivityStatus> get connectionChange => _connectionChangeController.stream;

  final _connectionChangeController =
  StreamController<ConnectivityStatus>.broadcast();

  void dispose() {
    _connectionSubscription.cancel();
    _connectionChangeController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<ConnectivityStatus> checkConnection() async {
    final previousConnection = hasConnection;
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        hasConnection = ConnectivityStatus.offline;
      } else {
        final client = http.Client();
        try {
          final response = await http.head(Uri.parse('https://www.google.com'));
          if (response.statusCode == 200) {
            hasConnection = ConnectivityStatus.online;

          } else {
            hasConnection = ConnectivityStatus.offline;

          }
        } catch (_) {
          hasConnection = ConnectivityStatus.offline;

        } finally {
          client.close();
        }
      }
    } catch (_) {
      hasConnection = ConnectivityStatus.offline;
      print('prueba >>> ingreso 6 ${hasConnection}');

    }
    if (previousConnection != hasConnection) {
      _connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }
}
