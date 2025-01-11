import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';


import '../provider/provider_principal.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static const routePage = CommonLabel.routeHome;

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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            // currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: 1,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}
