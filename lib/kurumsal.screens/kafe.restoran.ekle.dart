import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import 'kafe.restoran.detay.ekle.dart';

class KafeRestoranEkle extends StatefulWidget {
  const KafeRestoranEkle({super.key});

  @override
  State<KafeRestoranEkle> createState() => _KafeRestoranEkleState();
}

class _KafeRestoranEkleState extends State<KafeRestoranEkle> {
  late String kafe_isim;
  late String il;
  late String ilce;
  late String adres;
  String mekanId="";
  String kafeId=Uuid().v4();


  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final kafeReferans =
  FirebaseFirestore.instance.collection("kafeRestoran");
  XFile? file;

  // Resim seçme ve çekme için ImagePicker nesnesi
  File? image; // Seçilen veya çekilen resmin dosya referansı
  String imageURL = "";

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
                      height: 60,
                    ),
                    Text(
                      "Mekan Bilgileri Ekle ",
                      style: GoogleFonts.berkshireSwash(
                          fontSize: 25,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: TextFormField(
                          style: const TextStyle(
                              fontSize: 15, color: Colors.brown),
                          decoration: const InputDecoration(
                            hintText: "Mekan İsmi",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Lütfen Mekanınızın İsmini Giriniz ";
                            }
                          },
                          onSaved: (value) {
                            kafe_isim = value!;
                          }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: TextFormField(
                          style: const TextStyle(
                              fontSize: 15, color: Colors.brown),
                          decoration: const InputDecoration(
                            hintText: "Mekan İl Bilgisi",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Lütfen İl Bilgisi Giriniz ";
                            }
                          },
                          onSaved: (value) {
                            il = value!;
                          }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: TextFormField(
                        style:
                        const TextStyle(fontSize: 15, color: Colors.brown),
                        decoration: const InputDecoration(
                          hintText: "Mekan İlçe Bilgisi",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Lütfen İlce Bilgisini Giriniz ";
                          }
                        },
                        onSaved: (value) {
                          ilce = value!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: TextFormField(
                          style: const TextStyle(
                              fontSize: 15, color: Colors.brown),
                          decoration: const InputDecoration(
                            hintText: "Mekanın Adres Bilgisi",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Lütfen Adres Bilgisini Giriniz ";
                            }
                          },
                          onSaved: (value) {
                            adres = value!;
                          }),
                    ),


                    const SizedBox(
                      height: 50,
                    ),
                    Column(children: [
                      Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: image == null
                              ? const Center(child: Text("Resim Seçilmedi"))
                              : Image.file(image!))
                    ]),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Mekanınızla İlgili Görsel Ekleyiniz"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              kameraFotoCek();
                            },
                            icon: const Icon(
                              Icons.camera_alt_sharp,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              galeridenFotoSec();
                            },
                            icon: const Icon(
                              Icons.folder_special,
                              size: 30,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (image == null) {
                            return;
                          }
                          String uniqueFileName =
                          DateTime
                              .now()
                              .millisecondsSinceEpoch
                              .toString();
                          Reference referenceRoot =
                          FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                          referenceRoot.child("images");
                          Reference referenceImageUpload =
                          referenceDirImages.child(uniqueFileName);
                          try {
                            await referenceImageUpload.putFile(image!);
                            imageURL =
                            await referenceImageUpload.getDownloadURL();
                          } catch (error) {}
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();


                            // Mekan bilgilerini Firestore'a ekleyin
                            final mekanReferans =
                            await kafeReferans.add({
                              "kafe isim": kafe_isim,
                              "il": il,
                              "ilce": ilce,
                              "kullaniciid": auth.currentUser!.uid,
                              "adres": adres,
                              "kafe resim":imageURL,
                              "kafeId":kafeId

                            });

                            // Mekan ID'sini sakla
                            setState(() {
                              mekanId = mekanReferans.id;

                            });

                            Future.delayed(Duration.zero, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  KafeRestoranDetayEkle(mekanId: mekanId)));});
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: BeveledRectangleBorder(
                                borderRadius: (BorderRadius.circular(5)))),
                        child: const Text(
                          "Mekan Ekle ",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )),


                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future kameraFotoCek() async {
    final picker = ImagePicker();
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request().then((value) async {
        XFile? file = await picker.pickImage(source: ImageSource.camera);

        setState(() {
          if (file != null) {
            image = File(file.path);
          } else {
            print('No image selected.');
          }
        });
      });
    }
  }

  Future galeridenFotoSec() async {
    final picker = ImagePicker();
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request().then((value) async {
        XFile? file = await picker.pickImage(source: ImageSource.gallery);

        setState(() {
          if (file != null) {
            image = File(file.path);
          } else {
            print('No image selected.');
          }
        });
      });
    }
  }
}