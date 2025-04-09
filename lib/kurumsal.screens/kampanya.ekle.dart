import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';

import '../companents/tapbarcontroller.kurumsal.dart';

class KampanyaEkle extends StatefulWidget {
  const KampanyaEkle({super.key});

  @override
  State<KampanyaEkle> createState() => _KampanyaEkleState();
}

class _KampanyaEkleState extends State<KampanyaEkle> {
  late String kafe_isim;
  late String il;
  late String ilce;
  late String fiyat;
  late String adres;
late String kampanyali_fiyat;
  late String tarih;
  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final referance= FirebaseFirestore.instance
      .collection("kafeRestoran").doc("kampanya").collection("kampanyalar");
  XFile? file;
  // Resim seçme ve çekme için ImagePicker nesnesi
  File? image; // Seçilen veya çekilen resmin dosya referansı
  String imageURL="";
  TextEditingController tarihController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  late DateTime selectedDate = DateTime.now();
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
                      height: 50,
                    ),
                    Text(
                      "Kampanya Yapılacak Mekan Bilgileri ",
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
                      height: 15,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _selectDate(context, true),
                            child: const Text("Başlangıç Tarihi Seç"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => _selectDate(context, false),
                            child: const Text("Bitiş Tarihi Seç"),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: TextFormField(
                        controller: tarihController,

                        style: const TextStyle(fontSize: 15, color: Colors.brown),
                        decoration: const InputDecoration(
                          hintText: "Mekan Rezerve Ettirilmek İstenen Tarih Bilgisi",
                        ),
                        validator: (value) {
                          if (selectedStartDate.isAfter(selectedEndDate)) {
                            return "Geçerli bir tarih aralığı seçiniz";
                          }
                        },
                        onSaved: (value) {
                          // Seçilen tarih aralığını bir stringe çevirin
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          final String formattedStartDate = formatter.format(selectedStartDate);
                          final String formattedEndDate = formatter.format(selectedEndDate);
                          tarih = '$formattedStartDate - $formattedEndDate';
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
                            hintText: "Ücret Bilgisi",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Lütfen İstenen Ücret Bilgisini Giriniz ";
                            }
                          },
                          onSaved: (value) {
                            fiyat = value!;
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
                            hintText: "Kampanyalı Ücret Bilgisi",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Lütfen İstenen Ücret Bilgisini Giriniz ";
                            }
                          },
                          onSaved: (value) {
                            kampanyali_fiyat = value!;
                          }),
                    ),
                    Column(children: [
                      Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: image == null
                              ? const Center(child: Text("Resim Seçilmedi"))
                              : Image.file(image!))
                    ]),
                    const SizedBox(
                      height: 10,
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
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (image == null) {
                            return;
                          }
                          String uniqueFileName=DateTime.now().millisecondsSinceEpoch.toString();
                          Reference referenceRoot =
                          FirebaseStorage.instance.ref();
                          Reference referenceDirImages=referenceRoot.child("images");
                          Reference referenceImageUpload=referenceDirImages.child(uniqueFileName);
                          try{
                            await referenceImageUpload.putFile(image!);
                            imageURL= await referenceImageUpload.getDownloadURL();


                          }catch(error){


                          }
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            // selectedStartDate ve selectedEndDate'yi bir stringe çevirip Firebase'e ekleyin
                            final DateFormat formatter = DateFormat('dd-MM-yyyy');
                            final String formattedStartDate = formatter.format(selectedStartDate);
                            final String formattedEndDate = formatter.format(selectedEndDate);

                            Map<String,String> veriGonder={
                              "kafe isim": kafe_isim,
                              "il": il,
                              "ilce": ilce,
                              "fiyat": fiyat,
                              "kullaniciid": auth.currentUser!.uid,
                              "adres": adres,
                              "rezerve edilecek tarih": tarih,
                              "kampanyalı fiyat":kampanyali_fiyat,
                              "images":imageURL
                            };
                            referance.add(veriGonder);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Kullanıcı Başarıyla Kaydedildi,giriş sayfasına yönlendiriliyorsunuz")),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KTapBarController()));
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: BeveledRectangleBorder(
                                borderRadius: (BorderRadius.circular(5)))),
                        child: const Text(
                          "Mekan Ekle ",
                          style: TextStyle(fontSize: 30, color: Colors.white),

                        )
                    )],
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
      await Permission.storage.request().then((value) async{
        XFile? file = await picker.pickImage(source: ImageSource.camera);

        setState(() {
          if (file != null) {
            image = File(file.path);
          } else {
            print('No image selected.');
          }
        });
      }

      );}}
  Future galeridenFotoSec() async {
    final picker = ImagePicker();
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request().then((value) async{
        XFile? file = await picker.pickImage(source: ImageSource.gallery);

        setState(() {
          if (file != null) {
            image = File(file.path);
          } else {
            print('No image selected.');
          }
        });
      }

      );}}
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? selectedStartDate : selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = pickedDate;
        } else {
          selectedEndDate = pickedDate;
        }
        tarihController.text =
        '${DateFormat('dd-MM-yyyy').format(selectedStartDate)} - ${DateFormat('dd-MM-yyyy').format(selectedEndDate)}';
      });
    }
  }
}
