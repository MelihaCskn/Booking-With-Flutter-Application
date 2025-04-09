
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import '../companents/tapbarcontroller.kurumsal.dart';


class KafeRestoranDetayEkle extends StatefulWidget {
  final String mekanId;
 const KafeRestoranDetayEkle({super.key, required this.mekanId});



  @override
  State<KafeRestoranDetayEkle> createState() => _KafeRestoranDetayEkleState();
}

class _KafeRestoranDetayEkleState extends State<KafeRestoranDetayEkle> {
  late String tek_kisilik_masa_sayisi;
  late String tek_kisilik_masa_fiyati;
  late String iki_kisilik_masa_sayisi;
  late String iki_kisilik_masa_fiyati;
  late String uc_kisilik_masa_sayisi;
  late String uc_kisilik_masa_fiyati;
  late String dort_kisilik_masa_fiyati;
  late String dort_kisilik_masa_sayisi;
  late String toplu_masa_fiyati;
  late String toplu_masa_sayisi;
  late String tarih;

  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController tarihController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  late DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

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
                      "Rezerve Detay Bilgileri Ekle ",
                      style: GoogleFonts.berkshireSwash(
                          fontSize: 25,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.brown),
                                decoration: const InputDecoration(
                                  hintText: "1 Kişilik Masa Sayısı",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Lütfen Masa Sayısı Giriniz ";
                                  }
                                },
                                onSaved: (value) {
                                  tek_kisilik_masa_sayisi = value!;
                                }),
                          ),
                          SizedBox(width: 10,),
                          Expanded(child:
                          TextFormField(
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.brown),
                              decoration: const InputDecoration(
                                hintText: "1 Kişilik Masa Fiyatı",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Lütfen Masa Fiyatı Giriniz ";
                                }
                              },
                              onSaved: (value) {
                                tek_kisilik_masa_fiyati = value!;
                              }),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style:
                              const TextStyle(
                                  fontSize: 15, color: Colors.brown),
                              decoration: const InputDecoration(
                                hintText: "2 Kişilik Masa Sayısı",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Lütfen İlce Bilgisini Giriniz ";
                                }
                              },
                              onSaved: (value) {
                                iki_kisilik_masa_sayisi = value!;
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.brown),
                                decoration: const InputDecoration(
                                  hintText: "2 Kişilik Masa Fiyatı",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Lütfen Fiyat Bilgisi Giriniz";
                                  }
                                },
                                onSaved: (value) {
                                  iki_kisilik_masa_fiyati = value!;
                                }),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.brown),
                                decoration: const InputDecoration(
                                  hintText: "3 Kişilik Masa Sayısı",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Lütfen Masa Sayısı Giriniz ";
                                  }
                                },
                                onSaved: (value) {
                                  uc_kisilik_masa_sayisi = value!;
                                }),
                          ),
                          SizedBox(width: 10,),
                          Expanded(child:
                          TextFormField(
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.brown),
                              decoration: const InputDecoration(
                                hintText: "3 Kişilik Masa Fiyatı",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Lütfen Masa Fiyatı Giriniz ";
                                }
                              },
                              onSaved: (value) {
                                uc_kisilik_masa_fiyati = value!;
                              }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.brown),
                                decoration: const InputDecoration(
                                  hintText: "4 Kişilik Masa Sayısı",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Lütfen Masa Sayısı Giriniz ";
                                  }
                                },
                                onSaved: (value) {
                                  dort_kisilik_masa_sayisi = value!;
                                }),
                          ),
                          SizedBox(width: 10,),
                          Expanded(child:
                          TextFormField(
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.brown),
                              decoration: const InputDecoration(
                                hintText: "4 Kişilik Masa Fiyatı",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Lütfen Masa Fiyatı Giriniz ";
                                }
                              },
                              onSaved: (value) {
                                dort_kisilik_masa_fiyati = value!;
                              }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.brown),
                                decoration: const InputDecoration(
                                  hintText: "Toplu Masa Sayısı",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Lütfen Masa Sayısı Giriniz ";
                                  }
                                },
                                onSaved: (value) {
                                  toplu_masa_sayisi = value!;
                                }),
                          ),
                          SizedBox(width: 10,),
                          Expanded(child:
                          TextFormField(
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.brown),
                              decoration: const InputDecoration(
                                hintText: "Toplu Masa Fiyatı",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Lütfen Masa Fiyatı Giriniz ";
                                }
                              },
                              onSaved: (value) {
                                toplu_masa_fiyati = value!;
                              }),
                          )
                        ],
                      ),
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
                        style:
                        const TextStyle(fontSize: 15, color: Colors.brown),
                        decoration: const InputDecoration(
                          hintText:
                          "Mekan Rezerve Ettirilmek İstenen Tarih Bilgisi",
                        ),
                        validator: (value) {
                          if (selectedStartDate.isAfter(selectedEndDate)) {
                            return "Geçerli bir tarih aralığı seçiniz";
                          }
                        },
                        onSaved: (value) {
                          // Seçilen tarih aralığını bir stringe çevirin
                          final DateFormat formatter = DateFormat('dd-MM-yyyy');
                          final String formattedStartDate =
                          formatter.format(selectedStartDate);
                          final String formattedEndDate =
                          formatter.format(selectedEndDate);
                          tarih = '$formattedStartDate - $formattedEndDate';
                        },
                      ),
                    ),

                    SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            final DateFormat formatter =
                            DateFormat('dd-MM-yyyy');
                            final String formattedStartDate =
                            formatter.format(selectedStartDate);
                            final String formattedEndDate =
                            formatter.format(selectedEndDate);

                            await firestore
                                .collection("kafeRestoran")
                                .doc(widget.mekanId)
                                .collection("rezere mekan bilgileri")
                                .add({
                              "1 kişilik masa sayısı": tek_kisilik_masa_sayisi,
                              "1 kişilik masa fiyatı": tek_kisilik_masa_fiyati,
                              "2 kişilik masa sayısı": iki_kisilik_masa_sayisi,
                              "2 kişilik masa fiyatı": iki_kisilik_masa_fiyati,
                              "3 kişilik masa sayısı": uc_kisilik_masa_sayisi,
                              "3 kişilik masa fiyatı": uc_kisilik_masa_fiyati,
                              "4 kişilik masa sayısı": dort_kisilik_masa_sayisi,
                              "4 kişilik masa fiyatı": dort_kisilik_masa_fiyati,
                              "toplu masa sayısı": toplu_masa_sayisi,
                              "toplu masa fiyatı": toplu_masa_fiyati,
                              "rezerve tarih": tarih
                            });

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
                            backgroundColor: Colors.teal,
                            shape: BeveledRectangleBorder(
                                borderRadius: (BorderRadius.circular(5)))),
                        child: const Text(
                          " Rezervasyon Bilgileri Ekle ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          )),
    );
  }

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
        '${DateFormat('dd-MM-yyyy').format(selectedStartDate)} - ${DateFormat(
            'dd-MM-yyyy').format(selectedEndDate)}';
      });


      void updateText() {
        final formattedDate = DateFormat('dd.MM.yyyy').format(selectedDate);
        dateController.text = formattedDate;
      }
    }
  }
}
