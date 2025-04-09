
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KafeRestoran extends StatefulWidget {
  String kafe_isim;
  String il;
  String ilce;
  String adres;
  String kafe_resim;



  KafeRestoran(
      {super.key,
        required this.kafe_isim,
        required this.ilce,
        required this.il,
        required this.adres,
        required this.kafe_resim,


      });

  @override
  State<KafeRestoran> createState() => _KafeRestoranState();
}

class _KafeRestoranState extends State<KafeRestoran> {

  late final String kafe_isim, il, ilce, adres,kafeId;
  String images="";
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

              Padding(
                padding: const EdgeInsets.only(top:20.0,bottom: 15),
                child: Container(
                  height: 150,
                  width: 150,
                  child:  Image.network(widget.kafe_resim),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Mekan İsmi:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo),),
                  SizedBox(width: 20,),
                  Text(
                    widget.kafe_isim,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Mekan Bulunduğu İl:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.il,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("İlçe:",style: GoogleFonts.yesevaOne(color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.ilce,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Adres:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
                  SizedBox(width: 20,),
                  Text(
                    widget.adres,
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