import 'package:flutter/material.dart';
import '../bireysel.screens/kafe.restoran.anasayfa.bireysel.dart';

import '../bireysel.screens/kafe.restoran.rezervasyonlarım.dart';
import '../bireysel.screens/kafe.restoran.bireysel.kampanyalar.dart';
import '../bireysel.screens/profil.bireysel.dart';


class BTapBarController extends StatefulWidget {  @override
State<BTapBarController> createState() => _BTapBarControllerState();
}

class _BTapBarControllerState extends State<BTapBarController> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    final screens = [
      SearchablePage(),
      Rezervasyonlarim(),
      KRKampanyalarBireysel(),
      BireyselProfil(),
    ];
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value){
            setState(() {
              selectedIndex=value;
            });
          },
          selectedItemColor: Colors.green[900],
          unselectedItemColor: Colors.black,
          items: [
            _customButtonNavigationBarItem(Icons.house,"Anasayfa"),
            _customButtonNavigationBarItem(Icons.event_note_sharp,"Randevularım"),
            _customButtonNavigationBarItem(Icons.offline_pin_rounded,"Kampanyalar"),
            _customButtonNavigationBarItem(Icons.person,"Profil"),
          ],
        ));

  }
  BottomNavigationBarItem _customButtonNavigationBarItem(
      IconData iconData,String label) =>BottomNavigationBarItem(icon:Icon(iconData),label: label
  );
}