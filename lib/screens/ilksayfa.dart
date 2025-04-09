

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezerve/bireysel.screens/bireysel.giri%C5%9F.dart';


import '../kurumsal.screens/kurumsal.giris.dart';



class IlkBolum extends StatefulWidget{
  const IlkBolum({super.key});

  @override
  State<IlkBolum> createState() => _IlkBolumState();
}

class _IlkBolumState extends State<IlkBolum> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/duvar2.jpg'),
              fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
          ),

        ),

        child:  Scaffold(
            backgroundColor: Colors.transparent,
            body:  Center(
              child: SingleChildScrollView(

                child: Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius:130,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/saat2.jpg'),
                      ),
                      const SizedBox(height: 15),
                      Text("YERİNİ AL",style: GoogleFonts.baskervville(fontSize: 35,color: Colors.brown,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 12,),
                      Text(" Geç Olmasın Güç De Olmasın ! ",style: GoogleFonts.satisfy(fontSize: 25,color: Colors.brown),),
                      const SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.only(right: 15,left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BireyselGiris()));
                                },
                                style: ElevatedButton.styleFrom(primary: Colors.brown,  shape: BeveledRectangleBorder(
                                    borderRadius:
                                    (BorderRadius.circular(5) ))),
                                child:
                                    Text("  BİREYSEL GİRİŞ  ",style: GoogleFonts.aDLaMDisplay(color: Colors.white,fontWeight: FontWeight.bold),),



                            ),
                            ElevatedButton(
                                onPressed:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>KurumsalGiris()));
                                },
                                style: ElevatedButton.styleFrom(primary: Colors.brown,  shape: BeveledRectangleBorder(
                                    borderRadius:
                                    (BorderRadius.circular(5) ))),
                                child:

                                    Text(" KURUMSAL GİRİŞ ",style: GoogleFonts.aDLaMDisplay(color: Colors.white,fontWeight: FontWeight.bold),),



                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}
