import 'package:flutter/material.dart';
import 'package:rezerve/kurumsal.screens/ayarlar.kurumsal.dart';
import 'package:rezerve/kurumsal.screens/kafe.restoran.anasayfa.kurumsal.dart';
import 'package:rezerve/kurumsal.screens/kafe.restoran.kampanyalar.kurumsal.dart';

import 'package:rezerve/kurumsal.screens/rezerve.edilenler.dart';

class KTapBarController extends StatefulWidget {
  @override
  State<KTapBarController> createState() => _KTapBarControllerState();
}

class _KTapBarControllerState extends State<KTapBarController> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      KRAnasayfaKurumsal(),
      RezerveEdilenler(),
      KRKampanyalarKurumsal(),
      KurumsalAyarlar()
    ];
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          selectedItemColor: Colors.green[900],
          unselectedItemColor: Colors.black,
          items: [
            _customButtonNavigationBarItem(Icons.house, "Mekan"),
            _customButtonNavigationBarItem(
                Icons.event_note_sharp, "Rezerve Edilenler"),
            _customButtonNavigationBarItem(
                Icons.offline_pin_rounded, "Kampanyalar"),
            _customButtonNavigationBarItem(Icons.settings, "Ayarlar"),
          ],
        ));
  }

  BottomNavigationBarItem _customButtonNavigationBarItem(
          IconData iconData, String label) =>
      BottomNavigationBarItem(icon: Icon(iconData), label: label);
}
