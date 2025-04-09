import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezerve/kurumsal.screens/kampanya.ekle.dart';

import '../models/kafeRestoran.kampanyali.dart';

class KRKampanyalarKurumsal extends StatefulWidget {
  @override
  State<KRKampanyalarKurumsal> createState() => _KRKampanyalarKurumsalState();
}

class _KRKampanyalarKurumsalState extends State<KRKampanyalarKurumsal> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Query kampanyalimekanlarim = FirebaseFirestore.instance
        .collection("kafeRestoran")
        .doc("kampanya")
        .collection("kampanyalar")
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green[400],
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KampanyaEkle()));
            },
            child: Icon(Icons.add),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  "-KAMPANYALI MEKANLARIM-",
                  style: GoogleFonts.berkshireSwash(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: kampanyalimekanlarim.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshots) {
                      return !snapshots.hasData
                          ? Etkinlik_yok()
                          : Flexible(
                              child: ListView.builder(
                                  itemCount: snapshots.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot kampanya =
                                        snapshots.data!.docs[index];
                                    return KampanyaliKafeRestoran(
                                      kafe_isim:
                                          kampanya["kafe isim"].toString(),
                                      tarih: kampanya["rezerve edilecek tarih"]
                                          .toString(),
                                      ilce: kampanya["ilce"].toString(),
                                      il: kampanya["il"].toString(),
                                      adres: kampanya["adres"].toString(),
                                      ucret: kampanya["fiyat"].toString(),
                                      kampanyaId: kampanya.id,
                                      images: kampanya["images"].toString(),
                                      kampanyali_fiyat:
                                          kampanya["kampanyalı fiyat"],
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
