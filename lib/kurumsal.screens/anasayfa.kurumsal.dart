import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezerve/companents/ansayfa_container.dart';

import '../companents/menu.kurumsal.dart';
import '../companents/tapbarcontroller.bireysel.dart';
import '../companents/tapbarcontroller.kurumsal.dart';

class KurumsalAnasayfa extends StatefulWidget {
  @override
  State<KurumsalAnasayfa> createState() => _KurumsalAnasayfaState();
}

class _KurumsalAnasayfaState extends State<KurumsalAnasayfa> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/duvar2.jpg'),
              fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
              ),
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            drawer: KurumsalMenu(),
            backgroundColor: Colors.transparent,
            body: Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Mekan Türünü Seçiniz",
                      style: GoogleFonts.ptSerif(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  SizedBox(
                    height: 5,
                  ),

                    Center(
                      child: AnasayfaContainer(
                        assetsName: "restoran.jpg",
                        textName: "Kafe/Restoran",

                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KTapBarController()));
                        },
                      ),
                    ),

                  Container(
                    width: 320,
                    child: Divider(
                      height: 20,
                      color: Colors.green,
                    ),
                  ),


                    Center(
                      child: AnasayfaContainer(
                        assetsName: "otel2.jpg",
                        textName: "Otel ",

                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KTapBarController()));
                        },
                      ),
                    ),

                  Container(
                    width: 320,
                    child: Divider(
                      height: 20,
                      color: Colors.green,
                    ),
                  ),
                  Center(
                    child: AnasayfaContainer(
                      assetsName: "dugunsalonu2.png",
                      textName: "Düğün Salonu ",

                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KTapBarController()));
                      },
                    ),
                  )
                ],
              ),
            ))));
  }
}
