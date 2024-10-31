import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../provider/provider_principal.dart';
import '../useful/useful_label.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeHome;

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    final pvPrincipal = context.read<ProviderPrincipal>();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      pvPrincipal.getDataBusiness();
      pvPrincipal.initLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pvPrincipal = context.watch<ProviderPrincipal>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: pvPrincipal.itemScreen[pvPrincipal.pageScreen],
            ),
          ],
        ),
        bottomNavigationBar: pvPrincipal.buildBottomBar(context));
  }
}
