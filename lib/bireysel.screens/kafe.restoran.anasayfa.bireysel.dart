import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'kafe.restoran.detay.görüntüle.dart';

class SearchablePage extends StatefulWidget {
  @override
  _SearchablePageState createState() => _SearchablePageState();
}

class _SearchablePageState extends State<SearchablePage> {
  final CollectionReference kafeRef =
  FirebaseFirestore.instance.collection("kafeRestoran");

  TextEditingController ilceController = TextEditingController();
  TextEditingController ilController = TextEditingController();

  late Query kafeQuery;

  @override
  void initState() {
    super.initState();
    kafeQuery = kafeRef;
  }

  @override

  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pxfuel.jpg'),
              fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15,left: 33,right: 33),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: ilController,
                          decoration: const InputDecoration(

                              prefixIcon: Icon(Icons.search,color: Colors.white,),
                              labelText: 'Mekan İl Bilgisi',
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: ilceController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search,color: Colors.white,),
                              labelText: 'Mekan İlce Bilgisi',
                              labelStyle: TextStyle(color: Colors.white)
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // İki aranan niteliğe göre arama yapılacak işlemler
                            searchKafeler();
                          },
                          child: Text('Arama Yap'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: kafeQuery.snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Bir hata oluştu: ${snapshot.error}');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text('Sonuç bulunamadı.'),
                              );
                            }

                            // Firestore'dan çekilen tüm belgeleri birleştirme
                            List<Map<String, dynamic>> mergedData = [];
                            snapshot.data!.docs.forEach((doc) {
                              Map<String, dynamic> data = doc.data() as Map<
                                  String,
                                  dynamic>;
                              mergedData.add(data);
                            });

                            // Birden fazla aynı şartı sağlayanları filtreleme
                            List<Map<String, dynamic>> filteredData = [];
                            Set<String> uniqueKeys = Set();
                            mergedData.forEach((data) {
                              String key = '${data['ilce']}-${data['il']}';
                              if (!uniqueKeys.contains(key)) {
                                uniqueKeys.add(key);
                                filteredData.add(data);
                              }
                            });

                            // Sonuçları ListView olarak gösterme
                            return ListView.builder(
                                itemCount: filteredData.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data = filteredData[index];
                                  return GestureDetector(
                                      onTap: () {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => KafeRestoranDetay(kafeData: data),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top:15,  right: 15, left: 15),
                                          child: Container(
                                              height: 300,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  border: Border.all(
                                                      color: Colors.yellow, width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(17))),
                                              child: Column(
                                                  children: [

                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          top: 20.0, bottom: 15),
                                                      child: Container(
                                                        height: 150,
                                                        width: 150,
                                                        child: Image.network(
                                                            data["kafe resim"]),
                                                      ),
                                                    ),

                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [

                                                        Text("Mekan İsmi:",
                                                          style: GoogleFonts.yesevaOne(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors.indigo),),
                                                        SizedBox(width: 20,),
                                                        Text(
                                                          data['kafe isim'],
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [

                                                        Text("Mekan Bulunduğu İl:",
                                                            style: GoogleFonts
                                                                .yesevaOne(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Colors.indigo)),
                                                        SizedBox(width: 20,),
                                                        Text(
                                                          data['il'],
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [

                                                        Text("İlçe:",
                                                            style: GoogleFonts
                                                                .yesevaOne(
                                                                color: Colors.indigo)),
                                                        SizedBox(width: 20,),
                                                        Text(
                                                          data['ilce'],
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [

                                                        Text("Adres:",
                                                            style: GoogleFonts
                                                                .yesevaOne(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Colors.indigo)),
                                                        SizedBox(width: 20,),
                                                        Text(
                                                          data['adres'],
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                        ),
                                                      ],
                                                    ),


                                                  ])
                                          )
                                      ) );

                                }

                            );
                          }
                      ))
                ]
            )

        ) );

  }
  void searchKafeler() {
    setState(() {
      kafeQuery = kafeRef
          .where('ilce', isEqualTo: ilceController.text.trim())
          .where('il', isEqualTo: ilController.text.trim());
    });
  }

}