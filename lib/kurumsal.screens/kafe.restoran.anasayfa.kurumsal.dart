



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/kafe.restoran.dart';


class KRAnasayfaKurumsal extends StatefulWidget {
  @override
  State<KRAnasayfaKurumsal> createState() => _KRAnasayfaKurumsalState();
}

class _KRAnasayfaKurumsalState extends State<KRAnasayfaKurumsal> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Query mekanlarim = FirebaseFirestore.instance
        .collection("kafeRestoran")
        .where("kullaniciid", isEqualTo: auth.currentUser!.uid);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/pxfuel.jpg'),
            fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 60,),
                Text("-MEKANLARIM-",
                  style: GoogleFonts.berkshireSwash(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                StreamBuilder<QuerySnapshot>(
                    stream: mekanlarim.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshots) {
                      return !snapshots.hasData
                          ? Etkinlik_yok()
                          : Flexible(
                        child: ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot kafeRestoran =
                              snapshots.data!.docs[index];
                              return KafeRestoran(
                                kafe_isim:
                                kafeRestoran["kafe isim"].toString(),
                                ilce: kafeRestoran["ilce"].toString(),
                                il: kafeRestoran["il"].toString(),
                                adres: kafeRestoran["adres"].toString(),
                                kafe_resim: kafeRestoran["kafe resim"].toString(),
                              );
                            }),
                      );
                    }),
              ],
            ),
          )),
    );
  }

  Etkinlik_yok() {
    return Center(
      child: Container(
        color: Colors.white,
        height: 400,
        width: 400,
        child: Text(
            "HENÜZ MEKAN EKLEMEDİNİZ AYARLARDAN REZERVASYON YAPTIRMAK İSTEDİĞİNİZ MEKAN BİLGİLERİNİ EKLEYEBİLİRSİNİZ"),
      ),
    );
  }
}