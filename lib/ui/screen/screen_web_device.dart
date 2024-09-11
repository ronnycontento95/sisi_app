import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_principal.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../useful/useful_label.dart';
import '../widgets/widget_appbar.dart';

class ScreenWebView extends StatefulWidget {
  static const routePage = UsefulLabel.routeScreenWebView;

  const ScreenWebView({Key? key}) : super(key: key);

  @override
  State<ScreenWebView> createState() => _ScreenWebViewState();
}

class _ScreenWebViewState extends State<ScreenWebView> {
  ProviderPrincipal? pvPrincipal;
  late final WebViewController _controllerWebView;

  @override
  void initState() {
    super.initState();
    pvPrincipal = Provider.of<ProviderPrincipal>(context, listen: false);

    if (pvPrincipal != null) {
      _controllerWebView = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..enableZoom(false)
        ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {});
            }
          },
        ))
        ..loadRequest(Uri.parse(
            'https://sisi.com.ec/aplicacion/celular/nodo_individual/${pvPrincipal!.idWebDevice}/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarHome(
          imagen:pvPrincipal!.companyResponse.imagen ?? "",
          business:  pvPrincipal!.companyResponse.nombre_empresa,
          topic:  pvPrincipal!.companyResponse.topic ?? ""),
      body: WebViewWidget(controller: _controllerWebView),
    );
  }
}
