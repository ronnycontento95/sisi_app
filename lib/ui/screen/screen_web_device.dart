
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../global/global.dart';

class ScreenwebView extends StatefulWidget {
  static const routePage = Global.routeScreenwebView;

  const ScreenwebView({Key? key}) : super(key: key);

  @override
  State<ScreenwebView> createState() => _ScreenwebViewState();
}

class _ScreenwebViewState extends State<ScreenwebView> {
  ProviderPrincipal? pvlogin;
  late final WebViewController _controllerWebView;
  bool? _showPage = true;

  @override
  void initState() {
    super.initState();
    pvlogin = Provider.of<ProviderPrincipal>(context, listen: false);
    _controllerWebView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          if (progress == 100) {
            setState(() {
              _showPage = false;
            });
          }
        },
      ))
      ..loadRequest(
          Uri.parse('https://sisi.com.ec/aplicacion/celular/nodo_individual/30/'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controllerWebView),
    );
  }
}
