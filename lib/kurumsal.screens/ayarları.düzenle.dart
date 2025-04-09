


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rezerve/bireysel.screens/profil.bireysel.dart';


import '../companents/tapbarcontroller.kurumsal.dart';

class AyarlariDuzenle extends StatefulWidget {
  const AyarlariDuzenle({super.key});

  @override
  State<AyarlariDuzenle> createState() => _AyarlariDuzenleState();
}

class _AyarlariDuzenleState extends State<AyarlariDuzenle> {
  late String kurum_isim;
  late String telno;
  late String sifre;

  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  XFile? file;

  File? kurumProfilImage;
  String kurumProfilImageURL="";


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
                      height: 75,
                    ),
                    Text(
                      "Kurum Profil Bilgileri Düzenle ",
                      style: GoogleFonts.berkshireSwash(
                          fontSize: 25,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold),
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
                            hintText: "Kurum İsim Düzenle",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Lütfen İsim Soyisim Giriniz ";
                            }
                          },
                          onSaved: (value) {
                            kurum_isim = value!;
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
                            hintText: "Telefon Numarası Düzenle",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Lütfen Telefon Numarasını Giriniz ";
                            }
                          },
                          onSaved: (value) {
                            telno = value!;
                          }),
                    ),
                    SizedBox(height: 30,),
                    Column(children: [
                      Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: kurumProfilImage == null
                              ? const Center(child: Text("Resim Seçilmedi",style: TextStyle(color: Colors.white),))
                              : Image.file(kurumProfilImage!))
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("KURUM FOTOGRAFI EKLEYEBİLİRSİNİZ"),


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
                      height: 50,
                    ),


                    ElevatedButton(
                        onPressed: () async {

                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            if (kurumProfilImage == null) {
                              return;
                            }
                            String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
                            Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                            Reference referenceDirImages=referenceRoot.child("kurumProfilImages");
                            Reference referenceImageUpload=referenceDirImages.child(uniqueFileName);
                            try{
                              await referenceImageUpload.putFile(kurumProfilImage!);
                              kurumProfilImageURL= await referenceImageUpload.getDownloadURL();


                            }catch(error){


                            }


                            Map<String,String> veriGonder={
                              "kurum isim": kurum_isim,
                              "telno": telno,
                              "kurumProfilImages":kurumProfilImageURL


                            };
                            final referance= await FirebaseFirestore.instance
                                .collection("corporate users").doc(auth.currentUser!.email).set(veriGonder,SetOptions(merge: true));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Değişiklikler Başarıyla Kaydedildi,Önceki Sayfaya Yönlendiriliyorsunuz")),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BireyselProfil()));
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: BeveledRectangleBorder(
                                borderRadius: (BorderRadius.circular(5)))),
                        child: const Text(
                          "Bilgilerimi Düzenle",
                          style: TextStyle(fontSize: 25, color: Colors.white),

                        )
                    )],
                ),
              ),
            ),
          )),
    );
  }
  Future galeridenFotoSec() async {
    final picker = ImagePicker();
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request().then((value) async{
        XFile? file = await picker.pickImage(source: ImageSource.gallery);

        setState(() {
          if (file != null) {
            kurumProfilImage = File(file.path);
          } else {
            print('No image selected.');
          }
        });
      }

      );}}
  Future kameraFotoCek() async {
    final picker = ImagePicker();
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request().then((value) async{
        XFile? file = await picker.pickImage(source: ImageSource.camera);

        setState(() {
          if (file != null) {
            kurumProfilImage = File(file.path);
          } else {
            print('No image selected.');
          }
        });
      }

      );}}



}


