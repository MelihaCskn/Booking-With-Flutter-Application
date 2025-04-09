import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezerve/bireysel.screens/profil.d%C3%BCzenle.dart';

class BireyselProfil extends StatefulWidget {
  const BireyselProfil({super.key});

  @override
  State<BireyselProfil> createState() => _BireyselProfilState();
}

class _BireyselProfilState extends State<BireyselProfil> {
  File? profilImages;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth bauth = FirebaseAuth.instance;
    Stream<DocumentSnapshot> documentstream = FirebaseFirestore.instance
        .collection("singular users")
        .doc(bauth.currentUser!.email)
        .snapshots();
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pxfuel.jpg'),
              fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
              ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: StreamBuilder<DocumentSnapshot>(
                stream: documentstream,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    return ListView(children: [
                      const SizedBox(height: 40),
                      profilImages != null
                          ? const Icon(
                        Icons.person,
                        size: 70,
                      )
                          : Container(
                  height: 200,
                  width: 200,
                  child: Image.network("${data["profilImages"]}"),
                  ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kullanıcı Bilgileri",
                              style: GoogleFonts.slabo27px(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfilDuzenle()));
                                },
                                icon: Icon(Icons.settings,
                                    color: Colors.white70)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(left: 15, bottom: 15),
                        margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 3, right: 3, bottom: 8, top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "İsim Soyisim:",
                                    style: GoogleFonts.slabo27px(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 3, right: 3, bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    data['isim'].toString(),
                                    style: GoogleFonts.slabo27px(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(left: 15, bottom: 15),
                        margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 3, right: 3, bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Mail :",
                                    style: GoogleFonts.slabo27px(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 3, right: 3, bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email_rounded,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    data["email"].toString(),
                                    style: GoogleFonts.slabo27px(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      color: Colors.black,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(left: 15, bottom: 15),
                        margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 3, right: 3, bottom: 8, top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Telefon Numarası :",
                                    style: GoogleFonts.slabo27px(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 3, right: 3, bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    data["telno"].toString(),
                                    style: GoogleFonts.slabo27px(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      color: Colors.black,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                })));
  }
}
