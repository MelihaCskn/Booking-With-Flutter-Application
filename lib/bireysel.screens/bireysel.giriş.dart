import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';



import 'package:rezerve/services/auth-services.dart';

import '../screens/sifremi.unuttum.dart';
import 'bireysel.kayıt.dart';

class BireyselGiris extends StatefulWidget {
  const BireyselGiris({super.key});

  @override
  State<BireyselGiris> createState() => _BireyselGirisState();
}

class _BireyselGirisState extends State<BireyselGiris> {
  String secilitext = "";
  String email = "", sifre = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  final formkey = GlobalKey<FormState>();

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
                    height: 85,
                  ),
                  Text(
                    "HOŞGELDİNİZ ",
                    style: GoogleFonts.berkshireSwash(
                        fontSize: 35,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "-Bireysel Kullanıcı Girişi-",
                    style: GoogleFonts.berkshireSwash(
                        fontSize: 20,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 90,
                  ),

                  const SizedBox(
                    height: 35,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
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
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 230),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: const Text(
                        "Şifremi Unuttum",
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        AuthServices()
                            .BireyselGirisYap(context, email: email, password: sifre);
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: BeveledRectangleBorder(
                            borderRadius: (BorderRadius.circular(5)))),
                    child: const Text(
                      "  GİRİŞ YAP  ",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hesabın Yok Mu ?",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BireyselKayit()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: BeveledRectangleBorder(
                                borderRadius: (BorderRadius.circular(5)))),
                        child: const Text(
                          " KAYDOL ",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  IconButton(
                      onPressed: () async {
                        await AuthServices().GoogleGirisYap(context);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        size: 40,
                      )),
                ],
              ),
            ),
          )),
        ));
  }
}
