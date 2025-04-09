import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IlArama extends StatefulWidget {
  @override
  State<IlArama> createState() => _IlAramaState();
}

class _IlAramaState extends State<IlArama> {
  TextEditingController aramabircontroller = TextEditingController();
List allresult=[];
  List resultList = [];
void initState(){
  getKafeRestoranSream();
  super.initState();


}
  @override
  void dispose() {
    aramabircontroller.dispose();
  }


  getKafeRestoranSream() async{
    var data =await FirebaseFirestore.instance.collection("kafeRestoran").orderBy("kafe isim").get();
    setState(() {
allresult=data.docs;
    });
  }

  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pxfuel.jpg'),
              fit: BoxFit.cover //yatayda dikeyde ekranı full kaplasın diye)
              ),
        ),
        child:  Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(child: Column(children: [
              TextField(
                  style: TextStyle(color: Colors.white),
                 onChanged: (value){
                 },
                  controller: aramabircontroller,
                  decoration: const InputDecoration(
                    labelText: "Mekan İl Ara",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: "Aramak için bişeyler yaz,",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  )),
              ListView.builder(
                itemCount: allresult.length,
                  itemBuilder: (context,index){
                  return Container(
                    child: Column(
                      children: [
                        Text(allresult[index]["kafe isim"]),
                        Text(allresult[index]["il"]),
                        Text(allresult[index]["ilce"]),
                        Text(allresult[index]["adres"]),
                        Text(allresult[index]["rezerve edilecek tarih"]),
                        Text(allresult[index]["ucret"]),

                      ],
                    ),
                  );
                  })


          ])
    )
  ));}
}
