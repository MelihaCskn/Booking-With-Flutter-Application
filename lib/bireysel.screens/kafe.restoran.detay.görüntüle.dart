
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KafeRestoranDetay extends StatefulWidget {
  final Map<String, dynamic> kafeData;

  KafeRestoranDetay({required this.kafeData});

  @override
  State<KafeRestoranDetay> createState() => _KafeRestoranDetayState();
}

class _KafeRestoranDetayState extends State<KafeRestoranDetay> {
  @override
  Widget build(BuildContext context) {
    // widget.kafeData üzerinden verilere erişebilirsiniz
    final Map<String, dynamic> kafeData = widget.kafeData;
     return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/pxfuel.jpg'),
    fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
    ),
    ),child:
      Scaffold(
        backgroundColor: Colors.transparent,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text("-Kafe Rezerve Detay-",
              style: GoogleFonts.berkshireSwash(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),),
           Padding(
                padding: const EdgeInsets.only(
                    top:15,  right: 15, left: 15),
                child: Container(

                    decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(
                            color: Colors.yellow, width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(17))),
                    child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 15),
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Image.network(
                                  kafeData["kafe resim"]),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            children: [

                              Text("Mekan İsmi:",
                                style: GoogleFonts.yesevaOne(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors.indigo),),
                              SizedBox(width: 20,),
                              Text(
                                kafeData['kafe isim'],
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            children: [

                              Text("Mekan Bulunduğu İl:",
                                  style: GoogleFonts
                                      .yesevaOne(
                                      fontWeight: FontWeight
                                          .bold,
                                      color: Colors.indigo)),
                              SizedBox(width: 20,),
                              Text(
                                kafeData['il'],
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            children: [

                              Text("İlçe:",
                                  style: GoogleFonts
                                      .yesevaOne(
                                      color: Colors.indigo)),
                              SizedBox(width: 20,),
                              Text(
                                kafeData['ilce'],
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            children: [

                              Text("Adres:",
                                  style: GoogleFonts
                                      .yesevaOne(
                                      fontWeight: FontWeight
                                          .bold,
                                      color: Colors.indigo)),
                              SizedBox(width: 20,),
                              Text(
                                kafeData['adres'],
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ],
                          ),


                        ])
                )
            ),
          ],
        ),
      ),
    ));
  }
}
