
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KampanyaliKafeRestoran extends StatefulWidget {
  String kafe_isim;
  String il;
  String ilce;
  String ucret;
  String adres;
  String tarih;
  String images;
  String kampanyaId;
  String kampanyali_fiyat;

  KampanyaliKafeRestoran(
      {super.key,
        required this.kafe_isim,
        required this.tarih,
        required this.ilce,
        required this.il,
        required this.adres,
        required this.ucret,
        required this.images,
        required this.kampanyaId,
        required this.kampanyali_fiyat
      });

  @override
  State<KampanyaliKafeRestoran> createState() => _KampanyaliKafeRestoranState();
}

class _KampanyaliKafeRestoranState extends State<KampanyaliKafeRestoran> {

  late final String kafe_isim, il, ilce, ucret, tarih, adres,kafeId,kampanyali_fiyat;
  String images="";
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 20,right: 15,left: 15),
      child: Container(
        height: 400,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(color: Colors.yellow, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(17))),
        child: Column(
      children:[

        Padding(
          padding: const EdgeInsets.only(top:20.0,bottom: 15),
          child: Container(
            height: 200,
            width: 200,
            child:  Image.network(widget.images),
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

          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Rezervasyona Açık Tarih Aralığı:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
              SizedBox(width: 20,),

            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.tarih,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Normal Fiyat",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.indigo)),
            SizedBox(width: 20,),
            Text(
              widget.ucret,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Kampanyalı Fiyat:",style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold,color: Colors.red[900])),
            SizedBox(width: 20,),
            Text(
              widget.kampanyali_fiyat,
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
