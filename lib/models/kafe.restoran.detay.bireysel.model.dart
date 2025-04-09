

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KafeRestoranDetayModel extends StatefulWidget {

  String tek_kisilik_masa_sayisi;
  String tek_kisilik_masa_fiyati;
  String cift_kisilik_masa_sayisi;
  String cift_kisilik_masa_fiyati;
  String uc_kisilik_masa_sayisi;
  String uc_kisilik_masa_fiyati;
  String dort_kisilik_masa_fiyati;
  String dort_kisilik_masa_sayisi;
  String toplu_masa_sayisi;
  String toplu_masa_fiyati;
  String tarih;


  KafeRestoranDetayModel(
      {super.key,
        required this.tek_kisilik_masa_sayisi,
        required this.cift_kisilik_masa_sayisi,
        required this.tek_kisilik_masa_fiyati,
        required this.cift_kisilik_masa_fiyati,
        required this.uc_kisilik_masa_sayisi,
        required this.uc_kisilik_masa_fiyati,required this.dort_kisilik_masa_sayisi,required this.toplu_masa_sayisi,
  required this.dort_kisilik_masa_fiyati,required this.toplu_masa_fiyati,required this.tarih,

      });

  @override
  State<KafeRestoranDetayModel> createState() => _KafeRestoranDetayModelState();
}

class _KafeRestoranDetayModelState extends State<KafeRestoranDetayModel> {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 20,right: 15,left: 15),
      child: Container(
        height: 300,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(color: Colors.yellow, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(17))),
        child: Column(
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("1 Kişilik Masa Sayisi:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo),),
                  SizedBox(width: 10,),
                  Text(
                    widget.tek_kisilik_masa_sayisi,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("1 Kişilik Masa Fiyatı:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo),),
                  SizedBox(width: 10,),
                  Text(
                    widget.tek_kisilik_masa_fiyati,
                    style: TextStyle(color: Colors.black),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("2 Kişilik Masa Sayisi:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.cift_kisilik_masa_sayisi,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("2 Kişilik Masa Fiyatı:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.cift_kisilik_masa_fiyati,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("3 Kişilik Masa Sayisi:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.uc_kisilik_masa_sayisi,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("3 Kişilik Masa Fiyatı:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.uc_kisilik_masa_fiyati,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("4 Kişilik Masa Sayisi:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.dort_kisilik_masa_sayisi,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("4 Kişilik Masa Fiyatı:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.dort_kisilik_masa_fiyati,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Toplu Masa Sayisi:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.toplu_masa_sayisi,
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("Toplu Masa Fiyatı:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.toplu_masa_fiyati,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),



            ]
        ),
      ),
    );
  }
}