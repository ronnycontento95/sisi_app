import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../config/network_status.dart';
import '../useful/useful_style_text.dart';

class WidgetNetwork extends StatefulWidget {
  final Widget? child;
  final IconData? iconStatus;
  final String? text;
  final String? textAlert;
  final String? message;
  final TextStyle? textStyle;
  final Color? background;
  final Function? onStatusLost;
  final Function? onStatusRecover;
  final Widget? body;

  const WidgetNetwork._(
      {this.child,
        this.iconStatus,
        this.text,
        this.textAlert,
        this.message,
        this.textStyle,
        this.background,
        this.onStatusLost,
        this.onStatusRecover,
        this.body});

  factory WidgetNetwork({
    required Widget child,
    Function? onStatusLost,
    Function? onStatusRecover,
  }) =>
      WidgetNetwork._(
        onStatusRecover: onStatusRecover,
        onStatusLost: onStatusLost,
        child: child,
      );

  factory WidgetNetwork.icon(
      {required Widget child,
        IconData iconStatus = Icons.cloud_off_rounded,
        Function? onStatusLost,
        Function? onStatusRecover}) =>
      WidgetNetwork._(
        iconStatus: iconStatus,
        onStatusRecover: onStatusRecover,
        onStatusLost: onStatusLost,
        child: child,
      );

  factory WidgetNetwork.text({
    required String text,
    TextStyle? textStyle,
    Function? onStatusLost,
    Function? onStatusRecover,
    Color? background = Colors.red,
  }) =>
      WidgetNetwork._(
        onStatusRecover: onStatusRecover,
        onStatusLost: onStatusLost,
        text: text,
        textStyle: textStyle,
        background: background,
      );

  factory WidgetNetwork.message({
    required String message,
    TextStyle? textStyle,
    Function? onStatusLost,
    Function? onStatusRecover,
    Color? background = Colors.grey,
  }) =>
      WidgetNetwork._(
        onStatusRecover: onStatusRecover,
        onStatusLost: onStatusLost,
        message: message,
        textStyle: textStyle,
        background: background,
      );

  factory WidgetNetwork.alert({
    required String textAlert,
    String? textAction,
    TextStyle? textStyle,
    Function? onStatusLost,
    Function? onStatusRecover,
    Color? background,
  }) =>
      WidgetNetwork._(
        textAlert: textAlert,
        onStatusRecover: onStatusRecover,
        onStatusLost: onStatusLost,
        textStyle: textStyle,
        background: background,
      );

  factory WidgetNetwork.body({
    Function? onStatusLost,
    Function? onStatusRecover,
    Color? background,
    required Widget body,
    required Widget child,
  }) =>
      WidgetNetwork._(
        onStatusRecover: onStatusRecover,
        onStatusLost: onStatusLost,
        background: background,
        body: body,
        child: child,
      );

  @override
  State<WidgetNetwork> createState() => _CustomStatusNetworkState();
}

class _CustomStatusNetworkState extends State<WidgetNetwork> {
  final networkStatus = NetworkStatus();
  ConnectivityStatus connectionStatus = ConnectivityStatus.online;
  StreamSubscription<ConnectivityStatus>? streamConnectivity;
  Timer? timerCheckStatus;
  bool hasRecovered = false;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    initSubscribe();
  }

  @override
  void dispose() {
    streamConnectivity?.cancel();
    super.dispose();
  }

  void initSubscribe() async {
    streamConnectivity?.cancel();
    streamConnectivity ??= networkStatus.connectionChange.listen(
          (result) {
        _updateConnectionStatus(result);
        checkConnection(false);
      },
    );
  }

  initConnectivity() async {
    var result = await networkStatus.checkConnection();
    checkConnection(false);
    _updateConnectionStatus(result, check: true);
  }

  Future<void> _updateConnectionStatus(ConnectivityStatus result,
      {bool check = false}) async {
    if (!mounted) {
      return Future.value(null);
    }
    if (!check) {
      if (connectionStatus != result) {
        if (result == ConnectivityStatus.online &&
            widget.onStatusRecover != null &&
            !hasRecovered) {
          widget.onStatusRecover?.call();
          hasRecovered = true;
        }
        if (result == ConnectivityStatus.offline &&
            widget.onStatusLost != null) {
          hasRecovered = false;
          widget.onStatusLost?.call();
        }
      }
    }
    setState(() {
      connectionStatus = result;
    });
  }

  Future<void> checkConnection(bool online) async {
    var statusConnection = await networkStatus.checkConnection();
    _updateConnectionStatus(
      statusConnection == ConnectivityStatus.online
          ? ConnectivityStatus.online
          : ConnectivityStatus.offline,
      check: statusConnection == ConnectivityStatus.online,
    );

    timerCheckStatus?.cancel();
    timerCheckStatus = Timer.periodic(Duration(seconds: online ? 30 : 5),
            (_) => checkConnection(connectionStatus == ConnectivityStatus.online));
  }

  @override
  Widget build(BuildContext context) {
    print("prueba online >>> ${connectionStatus}");
    if (widget.body != null) {
      print("prueba online 2 >>> ${connectionStatus}");

      return connectionStatus == ConnectivityStatus.online ||
          connectionStatus == ConnectivityStatus.none
          ? widget.body!
          : widget.child!;
    }

    if (connectionStatus == ConnectivityStatus.none) {
      return const SizedBox.shrink();
    }

    if (widget.iconStatus != null) {
      print("prueba online 3 >>> ${connectionStatus}");

      return connectionStatus == ConnectivityStatus.online
          ? widget.child!
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Icon(
          widget.iconStatus,
          color: Colors.red,
        ),
      );
    }

    if (widget.text != null) {
      print("prueba online 4 >>> ${connectionStatus}");
      return Visibility(
        visible: connectionStatus == ConnectivityStatus.online,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            color: widget.background,
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.text ?? 'Sin conexión a internet.',
                      style: widget.textStyle ??
                          const NormalStyle(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (widget.message != null) {
      return Visibility(
        visible: connectionStatus == ConnectivityStatus.offline,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20 / 2),
          child: AutoSizeText(
            widget.message ?? 'Sin conexión a internet.',
            style: widget.textStyle ?? const TitleStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (widget.textAlert != null) {
      return Visibility(
        visible: connectionStatus == ConnectivityStatus.offline,
        child: StatusNetwork(
          widget.textAlert!,
        ),
      );
    }

    return connectionStatus == ConnectivityStatus.online
        ? widget.child!
        : const SizedBox.shrink();
  }
}

class StatusNetwork extends StatelessWidget {
  const StatusNetwork(
      this.message, {
        Key? key,
      }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset(
              //   "${kIconsAlertPath}wifi-off.png",
              //   height: size.height * .3,
              // ),
              Icon(Icons.wifi_off),
              const SizedBox(height: 20),
              Text(message, style: const NormalStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
