import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezerve/companents/ansayfa_container.dart';

import '../companents/menu.bireysel.dart';
import '../companents/menu.kurumsal.dart';
import '../companents/tapbarcontroller.bireysel.dart';

class BireyselAnasayfa extends StatefulWidget {
  @override
  State<BireyselAnasayfa> createState() => _BireyselAnasayfaState();
}

class _BireyselAnasayfaState extends State<BireyselAnasayfa> {
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
            drawer: BireyselMenu(),
            backgroundColor: Colors.transparent,
            body: Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Yapmak İstediğiniz İşlemi Seçiniz",
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
                        textName: "Kafe/Restoran Rezervasyonu",

                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BTapBarController()));
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
                        textName: "Otel Rezervasyonu",

                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BTapBarController()));
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
                      textName: "Düğün Salonu Rezervasyon",

                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BTapBarController()));
                      },
                    ),
                  )
                ],
              ),
            ))));
  }
}
