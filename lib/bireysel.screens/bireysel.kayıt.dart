import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rezerve/services/auth-services.dart';

class BireyselKayit extends StatefulWidget {
  const BireyselKayit({super.key});

  @override
  State<BireyselKayit> createState() => _BireyselKayitState();
}

class _BireyselKayitState extends State<BireyselKayit> {
  String email = "", sifre = "", isim = "",telno="";
   String profilImages="";
  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
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
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Form(
            key: formkey,
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "BİREYSEL KAYIT ",
                    style: GoogleFonts.berkshireSwash(
                        fontSize: 30,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: TextFormField(
                        style:
                            const TextStyle(fontSize: 15, color: Colors.brown),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "İsim-Soyisim ",
                          icon: Icon(
                            Icons.account_box,
                            color: Colors.green,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Lütfen İsim Soyisim  Giriniz ";
                          }
                        },
                        onSaved: (value) {
                          isim = value!;
                        }),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: TextFormField(
                        style:
                        const TextStyle(fontSize: 15, color: Colors.brown),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "Telefon Numarası",
                          icon: Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Lütfen Telefon Numaranızı Giriniz ";
                          }
                        },
                        onSaved: (value) {
                          telno = value!;
                        }),
                  ),
                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 15, color: Colors.brown),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.brown),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Mailinizi Giriniz",
                        icon: Icon(
                          Icons.mail,
                          color: Colors.green,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Lütfen mailinizi giriniz ";
                        }
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: TextFormField(
                        style:
                            const TextStyle(fontSize: 15, color: Colors.brown),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "Sifrenizi Giriniz",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Lütfen sifrenizi giriniz ";
                          }
                        },
                        onSaved: (value) {
                          sifre = value!;
                        }),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        AuthServices()
                            .BireyselKayitOl(context, email: email, password: sifre, isim: isim, telno: telno, profilImages: profilImages);
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: BeveledRectangleBorder(
                            borderRadius: (BorderRadius.circular(5)))),
                    child: const Text(
                      " KAYIT OL ",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                ],
              ),
            ),
          )),
        ));
  }
}
